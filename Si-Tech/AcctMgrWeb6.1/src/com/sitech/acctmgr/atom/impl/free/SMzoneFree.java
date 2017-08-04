package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.free.MzoneFreeEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.free.SMzoneFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SMzoneFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IMzoneFree;
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
 * Created by wangyla on 2016/7/25.
 */
@ParamTypes({@ParamType(c = SMzoneFreeQueryInDTO.class, m = "query", oc = SMzoneFreeQueryOutDTO.class)})
public class SMzoneFree extends AcctMgrBaseService implements IMzoneFree {

    private IUser user;
    private IProd prod;
    private IGroup group;
    private IFreeDisplayer freeDisplayer;

    @Override
    public OutDTO query(InDTO inParam) {
        SMzoneFreeQueryInDTO inDTO = (SMzoneFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int curYm = DateUtils.getCurYm();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();
        String userGroupId = userInfo.getGroupId();

        ChngroupRelEntity regionInfo = group.getRegionDistinct(userGroupId, "2", inDTO.getProvinceId());
        String regionCode = regionInfo.getRegionCode();

        List<FreeMinBill> detailList = freeDisplayer.getFreeDetailList(phoneNo, curYm, "0");
        //需要将短信按定购的二批代码分类展示

        List<MzoneFreeEntity> mzoneFreeList = new ArrayList<>();
        List<UserPrcEntity> prcList = prod.getPdPrcId(idNo, true);
        for (UserPrcEntity prcEnt : prcList) {
            String prcId = prcEnt.getProdPrcid();
            String prcType = prcEnt.getPrcType(); /*0:主资费；1：附加资费*/
            String prcAttrType = prcEnt.getPrcClass();
            if (!this.isPrcIdByAttrType(prcAttrType)) {
                continue;
            }

            Map<String, Long> freeTotalMap = this.getFreeTotalMap(detailList, prcId);
            long voiceTotal = freeTotalMap.get("VOICE_TOTAL");
            long voiceUsed = freeTotalMap.get("VOICE_USED");
            long voiceRemain = freeTotalMap.get("VOICE_REMAIN");

            long smsTotal = freeTotalMap.get("SMS_TOTAL");
            long smsUsed = freeTotalMap.get("SMS_USED");
            long smsRemain = freeTotalMap.get("SMS_REMAIN");

            MzoneFreeEntity mzoneEntity = new MzoneFreeEntity();
            mzoneEntity.setProdPrcId(prcId);
            mzoneEntity.setProdPrcType(prcType);
            mzoneEntity.setRegionCode(regionCode);
            mzoneEntity.setSmsTotal(smsTotal);
            mzoneEntity.setSmsUsed(smsUsed);
            mzoneEntity.setSmsRemain(smsRemain);
            mzoneEntity.setTimeTotal(voiceTotal);
            mzoneEntity.setTimeUsed(voiceUsed);
            mzoneEntity.setTimeRemain(voiceRemain);

            mzoneFreeList.add(mzoneEntity);
        }


        SMzoneFreeQueryOutDTO outDTO = new SMzoneFreeQueryOutDTO();
        outDTO.setFreeList(mzoneFreeList);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    /**
     * 功能：判定资费是否是动感地带用户指定类型的资费
     * @param prcAttrType
     * @return true: 归属指定资费；false: 不是指定资费
     */
    private boolean isPrcIdByAttrType(String prcAttrType) {
        String[] attrArray = new String[]{"YnA0","YnA2","YnB2","YnBa","YnC2","YnD2","YnP0","YnE6","Yn3a","Yn40"};
        prcAttrType = prcAttrType.substring(0, 4);

        boolean flag = false;
        for (String attrType : attrArray) {
            if (attrType.equals(prcAttrType)) {
                flag = true;
                break;
            } else {
                flag = false;
            }
        }

        return flag;

    }

    /**
     * 获取优惠信息中指定资费的汇总信息
     * @param freeList
     * @param prcId
     * @return
     */
    private Map<String, Long> getFreeTotalMap(List<FreeMinBill> freeList, String prcId) {
        Map<String, Long> totalMap = new HashMap<>();

        long voiceTotal = 0;
        long voiceUsed = 0;
        long voiceRemain = 0;

        long smsTotal = 0;
        long smsUsed = 0;
        long smsRemain = 0;
        for (FreeMinBill freeEnt : freeList) {
            String busiCode = freeEnt.getBusiCode();
            String prcIdTmp = freeEnt.getProdPrcId();
            if (!prcIdTmp.equals(prcId)) {
                continue;
            }

            if (busiCode.equals("1")) {
                voiceTotal += freeEnt.getLongTotal();
                voiceUsed += freeEnt.getLongUsed();
                voiceRemain += freeEnt.getLongRemain();
            } else if (busiCode.equals("2")) {
                smsTotal += freeEnt.getLongTotal();
                smsUsed += freeEnt.getLongUsed();
                smsRemain += freeEnt.getLongRemain();
            }
        }

        safeAddToMap(totalMap, "VOICE_TOTAL", voiceTotal);
        safeAddToMap(totalMap, "VOICE_USED", voiceUsed);
        safeAddToMap(totalMap, "VOICE_REMAIN", voiceRemain);

        safeAddToMap(totalMap, "SMS_TOTAL", smsTotal);
        safeAddToMap(totalMap, "SMS_USED", smsUsed);
        safeAddToMap(totalMap, "SMS_REMAIN", smsRemain);

        return totalMap;
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

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }
}
