package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.query.FreeDispEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.S8123QryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8123QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.I8123;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2016/7/1.
 */

@ParamTypes({@ParamType(c = S8123QryInDTO.class, m = "query", oc = S8123QryOutDTO.class)})
public class S8123 extends AcctMgrBaseService implements I8123 {
    private IFreeDisplayer freeDisplayer;
    private IPreOrder preOrder;
    private IControl control;
    private IUser user;
    private IGroup group;

    @Override
    public OutDTO query(InDTO inParam) {
        S8123QryInDTO inDto = (S8123QryInDTO) inParam;

        String phoneNo = inDto.getPhoneno();
        int yearMonth = inDto.getYearmonth();
        String busiCode = inDto.getBusicode() == null ? "0" : inDto.getBusicode();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        long contractNo = userInfo.getContractNo();

        String regionCode = group.getRegionDistinct(userInfo.getGroupId(), "2", inDto.getProvinceId()).getRegionCode();

        //TODO 用户是否可查询流量限制（后续补充groovy）

        List<FreeMinBill> freeList/*免费分钟数明细*/ = freeDisplayer.getFreeDetailList(phoneNo, yearMonth, busiCode);

        /*
        * 需要将明细按busicode类型分组展示，每种类型带有小计功能及明细功能；
        * 封装每种busicode对应的处理方式，后续有复用时，可将这部分内容放到公共函数里；
        *
        */

        List<FreeDispEntity> dispList = this.getFreeDispList(freeList);


        //查询类统一接触
        // 取操作流水
        long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
        Map<String, Object> queryInfoMap = new HashMap<String, Object>();
        queryInfoMap.put("Header", inDto.getHeader());

        //报文OPR_INFO节点内容
        queryInfoMap.put("PAY_SN", loginAccept);
        queryInfoMap.put("LOGIN_NO", inDto.getLoginNo());
        queryInfoMap.put("GROUP_ID", inDto.getGroupId());
        queryInfoMap.put("OP_CODE", inDto.getOpCode());
        queryInfoMap.put("REGION_ID", regionCode);
        queryInfoMap.put("OP_NOTE", "用户优惠信息查询");
        queryInfoMap.put("CUST_ID_TYPE", "1");
        queryInfoMap.put("CUST_ID_VALUE", phoneNo);
        queryInfoMap.put("OP_TIME", DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));
        queryInfoMap.put("SERVICE_NAME","com_sitech_acctmgr_inter_query_I8123Svc_query");//调用该方法的当前接口
        queryInfoMap.put("ID_NO",idNo);
        queryInfoMap.put("CONTRACT_NO", contractNo);

        preOrder.sendQueryCntt(queryInfoMap);

        S8123QryOutDTO outDto = new S8123QryOutDTO();
        outDto.setFreeList(dispList);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    /**
     * 功能：将优惠信息明细列表按busicode合并，做小计，并返回列表明细
     *
     * @param freeList
     * @return
     */
    private List<FreeDispEntity> getFreeDispList(List<FreeMinBill> freeList) {

        Map<String, List<FreeMinBill>> indexMap = new HashMap<>();
        Map<String, Long[]> valueMap = new HashMap<>();

        for (FreeMinBill freeEnt : freeList) {
            String busiCode = freeEnt.getBusiCode();
            /*
             * 1: 语音
             * 2：短信
             * 3：GPRS
             * 5：WLAN
             */
            if (!busiCode.equals("1") && !busiCode.equals("2") && !busiCode.equals("3") && !busiCode.equals("5")) {
                continue;
            }

            String key = freeEnt.getBusiCode();

            if (indexMap.containsKey(key)) {
                indexMap.get(key).add(freeEnt);
            } else {
                List<FreeMinBill> busiFreeList = new ArrayList<>();
                busiFreeList.add(freeEnt);
                indexMap.put(key, busiFreeList);
            }

            if (valueMap.containsKey(key)) {
                long oldTotal = valueMap.get(key)[0];
                long oldUsed = valueMap.get(key)[1];
                long oldLastTotal = valueMap.get(key)[2];
                long oldLastUsed = valueMap.get(key)[3];

                long newTotal = oldTotal + freeEnt.getLongTotal();
                long newUsed = oldUsed + freeEnt.getLongUsed();
                long newLastTotal = oldLastTotal + freeEnt.getLongLastTotal();
                long newLastUsed = oldLastUsed + freeEnt.getLongLastUsed();

                Long[] counts = new Long[]{newTotal, newUsed, newLastTotal, newLastUsed};
                valueMap.put(key, counts);

            } else {
                Long[] counts = new Long[]{freeEnt.getLongTotal(), freeEnt.getLongUsed(), freeEnt.getLongLastTotal(), freeEnt.getLongLastUsed()};

                valueMap.put(key, counts);
            }
        }

        List<FreeDispEntity> outList = new ArrayList<>();
        for (String key : indexMap.keySet()) {
            FreeDispEntity freeDispEnt = new FreeDispEntity();

            String[] array = key.split("\\^");
            String busiName = this.getBusiDispName(array[0]);

            freeDispEnt.setBusiName(busiName);
            freeDispEnt.setDetailList(indexMap.get(key));
            freeDispEnt.setTotal(String.format("%d", valueMap.get(key)[0]));
            freeDispEnt.setUsed(String.format("%d", valueMap.get(key)[1]));
            freeDispEnt.setOutUsed(String.format("%d", valueMap.get(key)[1] - valueMap.get(key)[0]));


            outList.add(freeDispEnt);
        }


        return outList;
    }

    private String getBusiDispName(String busiCode) {

        Map<String, String> map = new HashMap<String, String>();

        safeAddToMap(map, "1", "语音优惠信息");
        safeAddToMap(map, "2", "短信优惠信息");
        safeAddToMap(map, "3", "GPRS优惠信息");
        safeAddToMap(map, "5", "WLAN优惠信息");

        return map.get(busiCode);
    }


    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IPreOrder getPreOrder() {
        return preOrder;
    }

    public void setPreOrder(IPreOrder preOrder) {
        this.preOrder = preOrder;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }
}
