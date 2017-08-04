package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.query.PrcIdTransEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.free.SMmsFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SMmsFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.free.IMmsFree;
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
 * Created by wangyla on 2017/2/23.
 */
@ParamTypes({
        @ParamType(c = SMmsFreeQueryInDTO.class, m = "query", oc = SMmsFreeQueryOutDTO.class)
})
public class SMmsFree extends AcctMgrBaseService implements IMmsFree {
    private IUser user;
    private IProd prod;
    private IBillAccount billAccount;
    private IFreeDisplayer freeDisplayer;
    private IGroup group;

    @Override
    public OutDTO query(InDTO inParam) {
        SMmsFreeQueryInDTO inDTO = (SMmsFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int queryYm = inDTO.getYearMonth();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        String userGroupId = userInfo.getGroupId();

        ChngroupRelEntity regionInfo = group.getRegionDistinct(userGroupId, "2", inDTO.getProvinceId());
        String regionCode = regionInfo.getRegionCode();

        //获取用户订购的彩信资费的二批代码列表
        Map<String, String> rateIndexMap = new HashMap<>();
        List<UserPrcEntity> prcList = prod.getPdPrcId(idNo, "1"); /*获取用户附加资费列表*/
        List<String> rateCodeList = new ArrayList<>();
        for (UserPrcEntity prcEntity : prcList) {
            if (isMmsPrcId(prcEntity.getProdPrcid())) { /*彩信包年资费？*/
                List<PrcIdTransEntity> detailList = billAccount.getDetailCodeList(prcEntity.getProdPrcid(), regionCode, null);
                for (PrcIdTransEntity detailEnt : detailList) {
                    String detailCode = detailEnt.getDetailCode();
                    if (!rateIndexMap.containsKey(detailCode)) {
                        safeAddToMap(rateIndexMap, detailCode, detailCode);
                    }
                }
            }

        }

        for (String key : rateIndexMap.keySet()) {
            rateCodeList.add(key);
        }

        List<FreeMinBill> freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "0");
        Map<String, Long> totalMap = this.getFreeTotalMap(freeDetailList, rateCodeList);


        long mmsTotal = totalMap.get("MMS_TOTAL");
        long mmsUsed = totalMap.get("MMS_USED");
        long mmsRemain = totalMap.get("MMS_REMAIN");

        SMmsFreeQueryOutDTO outDTO = new SMmsFreeQueryOutDTO();
        outDTO.setMmsTotal(mmsTotal);
        outDTO.setMmsUsed(mmsUsed);
        outDTO.setMmsRemain(mmsRemain);

        log.debug("OutDto=" + outDTO.toJson());

        return outDTO;
    }

    /**
     * 获取优惠信息中指定资费的汇总信息
     *
     * @param freeList
     * @param rateCodeList
     * @return
     */
    private Map<String, Long> getFreeTotalMap(List<FreeMinBill> freeList, List<String> rateCodeList) {
        Map<String, Long> totalMap = new HashMap<>();

        long mmsTotal = 0;
        long mmsUsed = 0;
        long mmsRemain = 0;
        for (FreeMinBill freeEnt : freeList) {
            String busiCode = freeEnt.getBusiCode();
            String favType = freeEnt.getFavType(); /*二批代码*/
            if (this.isSpecifiedCode(favType, rateCodeList)) {
                if (busiCode.equals("7")) {
                    mmsTotal += freeEnt.getLongTotal();
                    mmsUsed += freeEnt.getLongUsed();
                    mmsRemain += freeEnt.getLongRemain();
                }
            }
        }

        safeAddToMap(totalMap, "MMS_TOTAL", mmsTotal);
        safeAddToMap(totalMap, "MMS_USED", mmsUsed);
        safeAddToMap(totalMap, "MMS_REMAIN", mmsRemain);

        return totalMap;
    }

    private boolean isSpecifiedCode(String checkRateCode, List<String> sourceList) {
        boolean flag = false;

        if (sourceList == null || sourceList.isEmpty()) {
            flag = false;
        } else {
            for (String tmpStr : sourceList) {
                if (checkRateCode.equals(tmpStr)) {
                    flag = true;
                    break;
                }
            }
        }

        return flag;
    }

    private boolean isMmsPrcId(String prcId) {
        return false; //资费已下线，无可用资费
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }

    public IBillAccount getBillAccount() {
        return billAccount;
    }

    public void setBillAccount(IBillAccount billAccount) {
        this.billAccount = billAccount;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }
}
