package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.free.FamFreeUseInfoEntity;
import com.sitech.acctmgr.atom.domains.free.FamilyFreeFeeUserEntity;
import com.sitech.acctmgr.atom.domains.free.FamilyFunnyDispEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.FamilyEntity;
import com.sitech.acctmgr.atom.domains.user.UserGroupMbrEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.free.*;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IFamilyFree;
import com.sitech.jcf.core.exception.BusiException;
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
@ParamTypes({@ParamType(c = SFamilyFreeQueryInDTO.class, m = "query", oc = SFamilyFreeQueryOutDTO.class),
        @ParamType(c = SFamilyFreeFunnyQueryInDTO.class, m = "funnyQuery", oc = SFamilyFreeFunnyQueryOutDTO.class),
        @ParamType(c = SFamilyFreeShareQueryInDTO.class, m = "shareQuery", oc = SFamilyFreeShareQueryOutDTO.class)
})
public class SFamilyFree extends AcctMgrBaseService implements IFamilyFree {

    private IFreeDisplayer freeDisplayer;
    private IUser user;
    private IControl control;
    private IProd prod;

    @Override
    public OutDTO query(InDTO inParam) {
        SFamilyFreeQueryInDTO inDTO = (SFamilyFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int queryYm = inDTO.getYearMonth();

        List<FreeMinBill> freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "0");
        Map<String, Long> freeMap = freeDisplayer.getFamlilyFreeTotalMap(freeDetailList, inDTO.getChatFlag());

        SFamilyFreeQueryOutDTO outDTO = new SFamilyFreeQueryOutDTO();
        outDTO.setVoiceTotal(freeMap.get("VOICE_TOTAL"));
        outDTO.setVoiceUsed(freeMap.get("VOICE_USED"));
        outDTO.setSmsTotal(freeMap.get("SMS_TOTAL"));
        outDTO.setSmsUsed(freeMap.get("SMS_USED"));
        outDTO.setGprsTotal(freeMap.get("GPRS_TOTAL"));
        outDTO.setGprsUsed(freeMap.get("GPRS_USED"));
        outDTO.setMmsTotal(freeMap.get("MMS_TOTAL"));
        outDTO.setMmsUsed(freeMap.get("MMS_USED"));
        outDTO.setCmwapTotal(freeMap.get("CMWAP_TOTAL"));
        outDTO.setCmwapUsed(freeMap.get("CMWAP_USED"));

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    @Override
    public OutDTO funnyQuery(InDTO inParam) {
        SFamilyFreeFunnyQueryInDTO inDTO = (SFamilyFreeFunnyQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int queryYm = inDTO.getYearMonth();
        int curYm = DateUtils.getCurYm();

        List<FamilyFunnyDispEntity> famDispList = null;
        if (queryYm == curYm) {
            famDispList = this.getFamilyCurrentDispList(phoneNo, queryYm);
        }else {
            famDispList = this.getFamilyPastDispList(phoneNo, queryYm);
        }

        SFamilyFreeFunnyQueryOutDTO outDTO = new SFamilyFreeFunnyQueryOutDTO();
        outDTO.setFreeList(famDispList);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    /**
     * 家庭亲情网二期查询，当月信息查询
     *
     * @param phoneNo
     * @param queryYm
     * @return
     */
    private List<FamilyFunnyDispEntity> getFamilyCurrentDispList(String phoneNo, int queryYm) {
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);

        List<FamilyFunnyDispEntity> outDispList = new ArrayList<>();
        List<FreeMinBill> freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "1");
        long total = 0; //套餐应优惠总量
        long used = 0; //套餐内使用量
        String level = "";
        String killRate = "";
        String masterFlag = "";
        for (FreeMinBill freeEnt : freeDetailList) {
            if (!freeEnt.getBusiCode().equals("1")) {
                continue;
            }

            PubCodeDictEntity famPrcInfo = freeDisplayer.getFamPrcIdInfo(freeEnt.getProdPrcId());
            if (famPrcInfo == null) {
                continue;
            }

            //
            masterFlag = this.getFamilyMemberFlag(userInfo.getIdNo(), famPrcInfo.getStatus());

            total = freeEnt.getLongTotal();
            used = (freeEnt.getLongTotal() >= freeEnt.getLongUsed()) ? freeEnt.getLongUsed() : freeEnt.getLongTotal();

            Map<String, String> levelRateMap = this.getLevelAndKillRate(total, used);
            level = levelRateMap.get("LEVEL");
            killRate = levelRateMap.get("KILL_RATE");

            FamilyFunnyDispEntity famDispEnt = new FamilyFunnyDispEntity();
            famDispEnt.setLevel(level);
            famDispEnt.setMasterFlag(masterFlag);
            famDispEnt.setPkRate(killRate);
            famDispEnt.setUsed(used);
            famDispEnt.setFreeFee(used * 15); //单位为分, 0.15元/分钟
            famDispEnt.setGroupType(famPrcInfo.getStatus());
            famDispEnt.setProdPrcName(famPrcInfo.getCodeName()); //TODO 需要和资费表里数据比对数据的准确性
            outDispList.add(famDispEnt);
        }

        return outDispList;
    }

    /**
     * 功能：获取用户归属亲情网角色标识
     * @param idNo
     * @param famStatus
     * @return 0：家长； 1：成员
     */
    private String getFamilyMemberFlag(long idNo, String famStatus) {

        List<Long> memberRoleIds = this.getFamilyMemberRoleIds(famStatus);

        UserGroupMbrEntity groupMbrInfo = user.getFamilyMemberInfo(idNo, memberRoleIds);
        if (groupMbrInfo == null) {
            throw new BusiException(AcctMgrError.getErrorCode("0000","0000"), "该用户未办理亲情网业务");
        }

        long memberRoleId = groupMbrInfo.getMemberRoleId();

        long codeClass = 1047; //亲情网配置
        String groupId = String.format("%d", memberRoleId);
        List<PubCodeDictEntity> pubValueList = control.getPubCodeList(codeClass, groupId, null, famStatus);
        PubCodeDictEntity pubValue = null;
        if (pubValueList.size() > 0) {
            pubValue = pubValueList.get(0);
        }

        return (pubValue != null) ? pubValue.getGroupId() : "";
    }

    private List<Long> getFamilyMemberRoleIds(String famStatus) {
        long codeClass = 1047; //亲情网家庭成员角色配置
        List<PubCodeDictEntity> pubValueList = control.getPubCodeList(codeClass, null, null, famStatus);
        List<Long> mbrIdList = new ArrayList<>();
        for (PubCodeDictEntity pubValue : pubValueList) {
            mbrIdList.add(Long.parseLong(pubValue.getCodeId()));
        }

        return mbrIdList;
    }


    /**
     * 家庭亲情网二期查询，往月信息查询
     *
     * @param phoneNo
     * @param queryYm
     * @return
     */
    private List<FamilyFunnyDispEntity> getFamilyPastDispList(String phoneNo, int queryYm) {
        List<FamilyFunnyDispEntity> outDispList = new ArrayList<>();
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();

        List<FamilyFreeFeeUserEntity> freeList = freeDisplayer.getFamilyFreeFeeList(phoneNo, queryYm);
        for (FamilyFreeFeeUserEntity freeEnt : freeList) {
            FamilyFunnyDispEntity famDispEnt = new FamilyFunnyDispEntity();

            famDispEnt.setLevel(freeEnt.getLevel());
            famDispEnt.setPkRate(freeEnt.getPkRate());
            famDispEnt.setUsed(freeEnt.getVoiceUsed());
            famDispEnt.setProdPrcName(freeEnt.getGroupName());
            famDispEnt.setFreeFee(freeEnt.getFreeFee());
            famDispEnt.setGroupType(freeEnt.getGroupType());

            if (freeEnt.getCtrlFlag().equals("N")) {
                famDispEnt.setMasterFlag("1"); //成员
            } else if (freeEnt.getCtrlFlag().equals("O")) {
                famDispEnt.setMasterFlag("0"); //家长
                //获取群组内所有成员的使用量及优惠费用
                Map<String, Long> famUsedInfo = this.getFamilySumUsedInfo(idNo, queryYm, freeEnt.getGroupType());
                famDispEnt.setSumFreeFee(famUsedInfo.get("FREE_FEE"));
                famDispEnt.setSumUsed(famUsedInfo.get("VOICE_USED"));
            }

            outDispList.add(famDispEnt);

        }
        return outDispList;
    }

    private Map<String, String> getLevelAndKillRate(long timeTotal, long timeUsed) {
        String level = "";
        String killRate = "";

        if (timeTotal == 200 && timeUsed >= 0 && timeUsed < 60) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 150 * 100);
            level = "0";
        } else if (timeTotal == 200 && timeUsed >= 60 && timeUsed < 150) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 150 * 100);
            level = "1";
        } else if (timeTotal == 200 && timeUsed >= 150 && timeUsed <= 200) {
            killRate = String.format("%.2f%%", (0.95 + 0.05 * (timeUsed - 150) / 50) * 100);
            level = "2";
        } else if (timeTotal == 300 && timeUsed >= 0 && timeUsed < 100) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 250 * 100);
            level = "0";
        } else if (timeTotal == 300 && timeUsed >= 100 && timeUsed < 250) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 250 * 100);
            level = "1";
        } else if (timeTotal == 300 && timeUsed >= 250 && timeUsed <= 300) {
            killRate = String.format("%.2f%%", (0.95 + 0.05 * (timeUsed - 250) / 50) * 100);
            level = "2";
        } else if (timeTotal == 500 && timeUsed >= 0 && timeUsed < 150) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 400 * 100);
            level = "0";
        } else if (timeTotal == 500 && timeUsed >= 150 && timeUsed < 400) {
            killRate = String.format("%.2f%%", 0.95 * timeUsed / 400 * 100);
            level = "1";
        } else if (timeTotal == 500 && timeUsed >= 400 && timeUsed <= 500) {
            killRate = String.format("%.2f%%", (0.95 + 0.05 * (timeUsed - 400) / 100) * 100);
            level = "2";

        }

        Map<String, String> outMap = new HashMap<>();
        safeAddToMap(outMap, "LEVEL", level);
        safeAddToMap(outMap, "KILL_RATE", killRate);
        return outMap;
    }

    private Map<String, Long> getFamilySumUsedInfo(long idNo, int queryYm, String famType){
        Map<String, Long> outMap = new HashMap<>();
        //获取归属家庭的所有成员，并循环成员，获取总优惠信息
        List<Long> memberRoleIds = this.getFamilyMemberRoleIds(famType);
        UserGroupMbrEntity groupMbrInfo = user.getFamilyMemberInfo(idNo, memberRoleIds);
        if (groupMbrInfo == null) {
            throw new BusiException(AcctMgrError.getErrorCode("0000","0000"), "该用户未办理亲情网业务");
        }
        long groupId = groupMbrInfo.getGroupId(); //归属亲情网的群组ID
        //获取群组下用户列表
        List<FamilyEntity> famMbrList = user.getFamilyInfoByGroupId(groupId);
        String phoneNo = "";
        long voiceUsedSum = 0;
        long freeFeeSum = 0;
        for (FamilyEntity mbrEnt : famMbrList) {
            phoneNo = mbrEnt.getPhoneNo();
            List<FamilyFreeFeeUserEntity> freeList = freeDisplayer.getFamilyFreeFeeList(phoneNo, queryYm);
            for (FamilyFreeFeeUserEntity freeEnt : freeList) {

                voiceUsedSum += freeEnt.getVoiceUsed();
                freeFeeSum += freeEnt.getFreeFee();
            }
        }

        safeAddToMap(outMap, "VOICE_USED", voiceUsedSum);
        safeAddToMap(outMap, "FREE_FEE", freeFeeSum);

        return outMap;
    }

    @Override
    public OutDTO shareQuery(InDTO inParam) {

        SFamilyFreeShareQueryInDTO inDTO = (SFamilyFreeShareQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int yearMonth = inDTO.getYearMonth();

        List<FamFreeUseInfoEntity> voiceBaseList = new ArrayList<>(); /*家庭共享语音基本列表*/
        List<FamFreeUseInfoEntity> voiceLongList = new ArrayList<>(); /*家庭共享长途语音列表*/
        List<FamFreeUseInfoEntity> gprsNationList = new ArrayList<>(); /*家庭共享国内GPRS列表*/
        List<FamFreeUseInfoEntity> gprsProvList = new ArrayList<>(); /*家庭共享省内GPRS列表*/
        long voiceBaseTotal = 0; /*基本语音总优惠*/
        long voiceBaseUsed = 0; /*基本语音已使用*/
        long voiceBaseRemain = 0; /*基本语音剩余量*/
        long voiceLongTotal = 0; /*长途语音总优惠量*/
        long voiceLongUsed = 0; /*长途语音总使用量*/
        long voiceLongRemain = 0; /*长途语音剩余量*/
        long gprsTotal = 0; /*共享流量总优惠量（含结转）*/
        long gprsUsed = 0; /*共享流量已使用总量（含结转）*/
        long gprsRemain = 0; /*共享流量剩余量(含结转)*/

        List<FreeMinBill> freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, yearMonth, "Q");
        for (FreeMinBill fmb : freeDetailList) {
            String busiCode = fmb.getBusiCode();
            String favCode = fmb.getFavCode();
            if (!busiCode.equals("Q")) {
                continue;
            }

            String prcId = fmb.getProdPrcId();
            String prcAttrFlag = this.getPrcAttrValue(prcId); /*50005:共享流量类,省内共享语音,成员间共享语音*/
            prcAttrFlag = (prcAttrFlag == null) ? "5" : prcAttrFlag;

            if (favCode.equals("0") /*语音基本费*/ || favCode.equals("1") /*语音长途费*/) {
                FamFreeUseInfoEntity famFreeEnt = new FamFreeUseInfoEntity();
                famFreeEnt.setPrcId(fmb.getProdPrcId());
                famFreeEnt.setPrcidName(fmb.getProdPrcName());
                famFreeEnt.setTotal(fmb.getTotal());
                famFreeEnt.setLongTotal(fmb.getLongTotal());
                famFreeEnt.setUsed(fmb.getUsed());
                famFreeEnt.setLongUsed(fmb.getLongUsed());
                famFreeEnt.setRemain(fmb.getRemain());
                famFreeEnt.setLongRemain(fmb.getLongRemain());

                if (favCode.equals("0")){
                    voiceBaseList.add(famFreeEnt);
                }

                if (favCode.equals("1")) {
                    voiceLongList.add(famFreeEnt);
                }

                if (prcAttrFlag.equals("0") /*资费为省内共享语音*/) {
                    voiceBaseTotal += fmb.getLongTotal();
                    voiceBaseUsed += fmb.getLongUsed();
                    voiceBaseRemain += fmb.getLongRemain();
                } else if (prcAttrFlag.equals("2") /*资费为成员间共享语音*/) {
                    voiceLongTotal += fmb.getLongTotal();
                    voiceLongUsed += fmb.getLongUsed();
                    voiceLongRemain += fmb.getLongRemain();
                }

            }

            if (favCode.equals("3") /*GPRS 国内*/ || favCode.equals("2") /*GPRS 省内*/) {
                FamFreeUseInfoEntity famFreeEnt = new FamFreeUseInfoEntity();
                famFreeEnt.setPrcId(prcId);
                famFreeEnt.setPrcidName(fmb.getProdPrcName());
                famFreeEnt.setTotal(String.format("%.2f", fmb.getLongTotal() / 1024.0));
                famFreeEnt.setLongTotal(fmb.getLongTotal());
                famFreeEnt.setUsed(String.format("%.2f", fmb.getLongUsed() / 1024.0));
                famFreeEnt.setLongUsed(fmb.getLongUsed());
                famFreeEnt.setRemain(String.format("%.2f", fmb.getLongRemain() / 1024.0));
                famFreeEnt.setLongRemain(fmb.getLongRemain());

                if (favCode.equals("3")) {
                    gprsNationList.add(famFreeEnt);
                } else if (favCode.equals("2") && !prcId.equals("M052839")) { /*各家飞享10元*/
                    gprsProvList.add(famFreeEnt);
                }

                if ((favCode.equals("3") && fmb.getLongLastTotal() > 0) ||
                        (favCode.equals("2") && !prcId.equals("M052839"))) { /*有结转流量*/
                    FamFreeUseInfoEntity lastFamFreeEnt = new FamFreeUseInfoEntity();
                    lastFamFreeEnt.setPrcId(fmb.getProdPrcId());
                    lastFamFreeEnt.setPrcidName(fmb.getProdPrcName() + "上月结转流量");
                    lastFamFreeEnt.setTotal(String.format("%.2f", fmb.getLongLastTotal() / 1024.0));
                    lastFamFreeEnt.setLongTotal(fmb.getLongLastTotal());
                    lastFamFreeEnt.setUsed(String.format("%.2f", fmb.getLongLastUsed() / 1024.0));
                    lastFamFreeEnt.setLongUsed(fmb.getLongLastUsed());
                    lastFamFreeEnt.setRemain(String.format("%.2f", fmb.getLongLastRemain() / 1024.0));
                    lastFamFreeEnt.setLongRemain(fmb.getLongLastRemain());
                    if (favCode.equals("3")) {
                        gprsNationList.add(lastFamFreeEnt);
                    } else if (favCode.equals("2") && !prcId.equals("M052839")) { /*各家飞享10元*/
                        gprsProvList.add(lastFamFreeEnt);
                    }
                }

                if (prcAttrFlag.equals("1")) {
                    gprsTotal += fmb.getLongTotal() + fmb.getLongLastTotal(); /*流量+结转*/
                    gprsUsed += fmb.getLongUsed() + fmb.getLongLastUsed();
                    gprsRemain += fmb.getLongRemain() + fmb.getLongLastRemain();
                }

            }

        }

        SFamilyFreeShareQueryOutDTO outDTO = new SFamilyFreeShareQueryOutDTO();
        outDTO.setVoiceBaseList(voiceBaseList);
        outDTO.setVoiceLongList(voiceLongList);
        outDTO.setGprsNationList(gprsNationList);
        outDTO.setGprsProvList(gprsProvList);
        outDTO.setVoiceBaseTotal(String.format("%d", voiceBaseTotal));
        outDTO.setVoiceBaseUsed(String.format("%d", voiceBaseUsed));
        outDTO.setVoiceBaseRemain(String.format("%d",voiceBaseRemain));
        outDTO.setVoiceLongTotal(String.format("%d", voiceLongTotal));
        outDTO.setVoiceLongUsed(String.format("%d", voiceLongUsed));
        outDTO.setVoiceLongRemain(String.format("%d", voiceLongRemain));
        outDTO.setGprsTotal(String.format("%.2f", gprsTotal / 1024.0));
        outDTO.setGprsUsed(String.format("%.2f", gprsUsed / 1024.0));
        outDTO.setGprsRemain(String.format("%.2f", gprsRemain / 1024.0));

        log.debug("outDto=" + outDTO.toJson());

        return outDTO;
    }

    private String getPrcAttrValue(String prcId) {
        long codeClass = 1050;
        List<PubCodeDictEntity> codeList = control.getPubCodeList(codeClass, prcId, "50005", null, null);

        return (codeList == null || codeList.size() == 0) ? null : codeList.get(0).getCodeValue();
    }


    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }
}
