package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.free.*;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.free.SFreeOpenGprsQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SFreeOpenGprsQueryOutDTO;
import com.sitech.acctmgr.atom.dto.free.SFreeOpenQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SFreeOpenQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IFreeOpen;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.getString;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2017/6/6.
 */
@ParamTypes({
        @ParamType(c = SFreeOpenQueryInDTO.class, m = "query", oc = SFreeOpenQueryOutDTO.class),
        @ParamType(c = SFreeOpenGprsQueryInDTO.class, m = "gprsQuery", oc = SFreeOpenGprsQueryOutDTO.class)
})
public class SFreeOpen extends AcctMgrBaseService implements IFreeOpen {
    private IUser user;
    private IFreeDisplayer freeDisplayer;
    private IBillAccount billAccount;
    private IGroup group;
    private IProd prod;

    @Override
    public OutDTO query(InDTO inParam) {
        SFreeOpenQueryInDTO inDto = (SFreeOpenQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        SFreeOpenQueryOutDTO outDto = new SFreeOpenQueryOutDTO();

        String retCode = "0000";
        String retMsg = "成功";

        /*============开始处理业务==============*/

        String phoneNo = inDto.getPhoneNo();
        int curYm = DateUtils.getCurYm();
        curYm = DateUtils.addMonth(curYm, -1);

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
        if (userInfo == null) {
            retCode = "4005";
            retMsg = "使用用户手机号码非法（不存在）";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            return outDto;
        }

        String groupId = userInfo.getGroupId();
        String regionCode = group.getRegionDistinct(groupId, "2", inDto.getProvinceId()).getRegionCode();

        List<FreeMinBill> freeDetailList = null;
        try {
            freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, curYm, "0");

            System.out.println("=====================================");
            System.out.println(freeDetailList);
        } catch (BusiException e) {
            retCode = "5999";
            retMsg = "Socket服务端异常";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);
            return outDto;
        }

        Map<String/*prc_id*/, List<FreeMinBill>> inPlanMap = new HashMap<>();
        List<FreeMinBill> outPlanList = new ArrayList<>();
        if (freeDetailList != null && freeDetailList.size() > 0) {
            for (FreeMinBill freeEnt : freeDetailList) {
                String busiCode = freeEnt.getBusiCode();
                String favType = freeEnt.getFavType();
                String prcId = freeEnt.getProdPrcId();

                if (favType.equals("0002")) {
                    outPlanList.add(freeEnt);
                    continue;
                }

                /*只处理 1:语音 2:短信 3:GPRS 5:WLAN 7:彩信*/
                if (!(busiCode.equals("1") || busiCode.equals("2") || busiCode.equals("3")
                        || busiCode.equals("5") || busiCode.equals("7"))) {
                    continue;
                }

                if (billAccount.isFlexPrc(favType)) { //灵活账期，生失效时间为订购的生失效时间
                    Map<String, String> timeMap = prod.getPrcValidInfo(Long.parseLong(freeEnt.getInstanceId()));
                    String expDate = (timeMap != null) ? getString(timeMap, "EXP_DATE") : "";
                    freeEnt.setExpDate(expDate);

                } else if (billAccount.isDayPrc(favType)) { //包天套餐
                    freeEnt.setExpDate(String.format("%08d000000", DateUtils.addDays(DateUtils.getCurDay(), 1)));
                } else { //包月套餐
                    freeEnt.setExpDate(String.format("%06d01000000", DateUtils.addMonth(curYm, 1)));
                }


                /*先按资费合并信息，再将资费中信息按busi_code分组*/
                if (inPlanMap.containsKey(prcId)) {
                    inPlanMap.get(prcId).add(freeEnt);
                } else {
                    List<FreeMinBill> mapFreeList = new ArrayList<>();
                    mapFreeList.add(freeEnt);

                    inPlanMap.put(prcId, mapFreeList);
                }
            } //:: end for
        }

        List<FreeInPackageEntity> inList = new ArrayList<>();
        for (String prcId : inPlanMap.keySet()) {
            List<FreeMinBill> prcFreeList = inPlanMap.get(prcId);

            String prcName = prcFreeList.get(0).getProdPrcName();

            List<FreeDetailLv1InEntity> resInfo = this.getFreeClassInfo(regionCode, prcId, prcFreeList);

            FreeInPackageEntity inPlanInfo = new FreeInPackageEntity();
            inPlanInfo.setPrcName(prcName);
            inPlanInfo.setPrcId(prcId);
            inPlanInfo.setEffDate(prcFreeList.get(0).getEffDate());
            inPlanInfo.setExpDate(prcFreeList.get(0).getExpDate());
            inPlanInfo.setDetailList(resInfo);

            inList.add(inPlanInfo);
        }

        List<FreeOutPackageEntity> outList = this.getOutFreeClassInfo(outPlanList);

        FreePackageEntity packageEnt = new FreePackageEntity();
        packageEnt.setInList(inList);
        packageEnt.setOutList(outList);

        List<FreePackageEntity> freeList = new ArrayList<>();
        freeList.add(packageEnt);

        //拼接出参
        outDto.setRetCode(retCode);
        outDto.setRetMsg(retMsg);
        outDto.setQueryTime(DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));

        outDto.setFreeList(freeList);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    /**
     * 套餐内优惠分类展示
     * @param inFreeList
     * @return
     */
    private List<FreeDetailLv1InEntity> getFreeClassInfo(String regionCode, String prcId, List<FreeMinBill> inFreeList) {

        Map<String /*资源类型代码*/, List<FreeDetailLv3InEntity>> subResMap = new HashMap<>(); //按资源类型分类，保存对应的列表

        String resCode = null;
        String unit = null;
        Map<String, String> mapTmp = null;
        for (FreeMinBill freeEnt : inFreeList) {
            String busiCode = freeEnt.getBusiCode();
            mapTmp = this.getSecResInfo(busiCode, freeEnt.getUnitCode());
            resCode = mapTmp.get("RES_CODE");
            unit = mapTmp.get("UNIT");

            FreeDetailLv3InEntity detEnt = new FreeDetailLv3InEntity();
            detEnt.setTotal(freeEnt.getTotal());
            detEnt.setUsed(freeEnt.getUsed());
            detEnt.setRemain(freeEnt.getRemain());
            detEnt.setUnit(unit);
            detEnt.setExpireTime(""); //TODO

            if (subResMap.containsKey(resCode)) {
                subResMap.get(resCode).add(detEnt);
            } else {
                List<FreeDetailLv3InEntity> freeList = new ArrayList<>();
                freeList.add(detEnt);
                subResMap.put(resCode, freeList);
            }

            if (busiCode.equals("3") || busiCode.equals("5")) {
                if (freeEnt.getLongLastTotal() > 0) {
                    int yearMonth = Integer.parseInt(freeEnt.getYearMonth());
                    FreeDetailLv3InEntity detLastEnt = new FreeDetailLv3InEntity();
                    detLastEnt.setTotal(freeEnt.getLastTotal());
                    detLastEnt.setUsed(freeEnt.getLastUsed());
                    detLastEnt.setRemain(freeEnt.getLastRemain());
                    detLastEnt.setUnit(unit);
                    detLastEnt.setExpireTime(String.format("%6d%02d235959", yearMonth, DateUtils.getLastDayOfMonth(yearMonth)));
                    subResMap.get(resCode).add(detLastEnt);
                }
            }

        } //:: end 按rescode 分组

        List<FreeDetailLv1InEntity> outList = new ArrayList<>();
        for (String rescode : subResMap.keySet()) {
            FreeDetailLv1InEntity freeLv1Ent = new FreeDetailLv1InEntity();
            freeLv1Ent.setResCode(resCode);

            if (rescode.equals("04")) {
                if (freeDisplayer.is4GPrcId(prcId)) {
                    freeLv1Ent.setShareFlag(billAccount.isSharePrcId(prcId, regionCode) ? "0" : "1"); //0:共享；1：未共享
                }
            }

            List<FreeDetailLv2InEntity> freeLv2List = new ArrayList<>();
            FreeDetailLv2InEntity freeLv2Ent = new FreeDetailLv2InEntity();
            freeLv2Ent.setResName(this.getResName(rescode));
            freeLv2Ent.setFreeList(subResMap.get(rescode));

            freeLv2List.add(freeLv2Ent);

            freeLv1Ent.setDetailList(freeLv2List);
            outList.add(freeLv1Ent);
        } //:: end 按rescode 将数据封装

        return outList;
    }

    /**
     * 套餐外信息分类展示
     * @param inFreeList
     * @return
     */
    private List<FreeOutPackageEntity> getOutFreeClassInfo(List<FreeMinBill> inFreeList) {
        Map<String /*资源类型代码*/, List<FreeDetailLv2OutEntity>> resMap = new HashMap<>();

        String resCode = null;
        String unit = null;
        String resClass = null;
        Map<String, String> mapTmp = null;
        for (FreeMinBill freeEnt : inFreeList) {
            String busiCode = freeEnt.getBusiCode();
            mapTmp = this.getSecResInfo(busiCode, freeEnt.getUnitCode());
            resCode = mapTmp.get("RES_CODE");
            unit = mapTmp.get("UNIT");

            if (resCode.equals("05")) {
                resClass = "05";
            } else if (resCode.equals("04")) {
                //TODO 补充流量时，套餐外如何判断是省内，国内，还是国际
                String regionType = freeEnt.getRegionType();
                if (regionType.equals("02")) { //02:省内
                    resClass = "01";
                } else if (regionType.equals("01")) {
                    resClass = "02";
                } else {
                    resClass = "04";
                }
            }

            FreeDetailLv2OutEntity detEnt = new FreeDetailLv2OutEntity();
            detEnt.setUnit(unit);
            detEnt.setUsed(freeEnt.getUsed());
            detEnt.setResClass(resClass);
            detEnt.setChargeFee(""); //TODO 套餐外的费用需要补充

            if (resMap.containsKey(resCode)) {
                resMap.get(resCode).add(detEnt);
            } else {
                List<FreeDetailLv2OutEntity> freeList = new ArrayList<>();
                freeList.add(detEnt);

                resMap.put(resCode, freeList);
            }
        } //:: end for

        List<FreeOutPackageEntity> outList = new ArrayList<>();
        for (String rescode : resMap.keySet()) {
            FreeOutPackageEntity freeEnt = new FreeOutPackageEntity();
            freeEnt.setResCode(rescode);
            freeEnt.setDetailList(resMap.get(rescode));
            outList.add(freeEnt);
        }

        return outList;
    }

    private Map<String, String> getSecResInfo(String busiCode, String inUnit) {
        String resCode = "";
        String resName = "";
        String unit = "";
        if (busiCode.equals("1")) {
            resCode = "01";
            resName = "语音资源";
            unit = "01";
        } else if (busiCode.equals("2")) {
            resCode = "02";
            resName = "短信资源";
            unit = "02";
        } else if (busiCode.equals("7")) {
            resCode = "03";
            resName = "彩信资源";
            unit = "02";
        } else if (busiCode.equals("3")) {
            resCode = "04";
            resName = "GPRS资源";
            unit = "03";
        } else if (busiCode.equals("5")) {
            resCode = "05";
            resName = "WLAN资源";
            if (inUnit.equals("3")) { //按时长
                unit = "01";
            } else {
                unit = "03";
            }
        }

        Map<String, String> outMap = new HashMap<>();
        safeAddToMap(outMap, "RES_CODE", resCode);
        safeAddToMap(outMap, "RES_NAME", resName);
        safeAddToMap(outMap, "UNIT", unit);

        return outMap;
    }

    private String getResName(String resCode) {
        String resName = "";

        if (resCode.equals("01")) {
            resName = "语音资源";
        } else if (resCode.equals("02")) {
            resName = "短信资源";
        } else if (resCode.equals("03")) {
            resName = "彩信资源";
        } else if (resCode.equals("04")) {
            resName = "GPRS资源";
        } else if (resCode.equals("05")) {
            resName = "WLAN资源";
        }

        return resName;
    }

    @Override
    public OutDTO gprsQuery(InDTO inParam) {
        SFreeOpenGprsQueryInDTO inDto = (SFreeOpenGprsQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        SFreeOpenGprsQueryOutDTO outDto = new SFreeOpenGprsQueryOutDTO();

        String retCode = "0000";
        String retMsg = "成功";

        /*============开始处理业务==============*/

        String phoneNo = inDto.getPhoneNo();
        int curYm = DateUtils.getCurYm();
//        curYm = DateUtils.addMonth(curYm, -1);

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
        if (userInfo == null) {
            retCode = "4005";
            retMsg = "使用用户手机号码非法（不存在）";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            log.error("outDto=" + outDto.toJson());
            return outDto;
        }

        String groupId = userInfo.getGroupId();

        String regionCode = group.getRegionDistinct(groupId, "2", inDto.getProvinceId()).getRegionCode();


        long gprsShouldTotal = 0; //套餐内流量总量
        long gprsUsedTotal = 0; //流量使用总量（含套餐外流量）

        List<FreeMinBill> freeDetailList = null;

        try {
            freeDetailList = freeDisplayer.getFreeDetailList(phoneNo, curYm, "3", "0" /*普通流量*/);
        } catch (BusiException e) {
            retCode = "5999";
            retMsg = "Socket服务端异常";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            log.error("outDto=" + outDto.toJson());
            return outDto;
        }

        Map<String, FreeGprsDetailEntity> indexMap = new HashMap<>(); /*资费明细Map容器*/
        Map<String, Integer> numMap = new HashMap<>(); /*资费产品个数Map容器*/

        if (freeDetailList != null && freeDetailList.size() > 0) {

            for (FreeMinBill freeEnt : freeDetailList) {
                String busiCode = freeEnt.getBusiCode();
                String favType = freeEnt.getFavType();
                String prcId = freeEnt.getProdPrcId();
                String unitCode = freeEnt.getUnitCode();
                if (!busiCode.equals("3")) { //非GPRS流量，不处理
                    continue;
                }

                if (favType.equals("0002")) { //套餐外的流量使用量
                    gprsUsedTotal += freeEnt.getLongUsed();
                    continue; //套餐外使用量不计入订购套餐的列表中
                }

                gprsShouldTotal += freeEnt.getLongTotal() + freeEnt.getLongLastTotal();
                gprsUsedTotal += freeEnt.getLongUsed() + freeEnt.getLongLastUsed();

                /*boolean addFlag = false; *//*是否叠加包资费， true: 是；fasle：不是*//*
                if (freeDisplayer.isAddedGprs(prcId)) { //流量叠加包
                    addFlag = true;
                } else { //套餐内流量
                    addFlag = false;
                }*/

                String prcType = freeEnt.getPrcType();

                if (indexMap.containsKey(prcId)) {
                    FreeGprsDetailEntity prcDetailEnt = indexMap.get(prcId);
                    prcDetailEnt.setLongGprsTotal(prcDetailEnt.getLongGprsTotal() + freeEnt.getLongTotal() + freeEnt.getLongLastTotal());
                    prcDetailEnt.setLongGprsUsed(prcDetailEnt.getLongGprsUsed() + freeEnt.getLongUsed() + freeEnt.getLongLastUsed());

                    /*if (addFlag == true) {
                        int newnum = numMap.get(prcId) + 1;
                        numMap.put(prcId, newnum);
                    }*/

                    String sendType = prcDetailEnt.getSendType();
                    if (sendType.equals("1")) { //0: 可转赠；1：不可转赠
                        if (billAccount.isSendPrcId(prcId, favType)) {
                            sendType = "0";
                        }
                        prcDetailEnt.setSendType(sendType);
                    }

                    if (prcType.equals("1")) { //附加资费累计个数 //TODO
                        int newnum = numMap.get(prcId) + 1;
                        numMap.put(prcId, newnum);
                    }
                } else {

                    int carryFlag = billAccount.getGprsState(prcId, regionCode); //获取资费是否为可结转资费
                    String sendType = "1";
                    if (billAccount.isSendPrcId(prcId, favType)) {
                        sendType = "0";
                    }

                    String shareType = "";
                    if (freeDisplayer.is4GPrcId(freeEnt.getProdPrcId())) {
                        shareType = billAccount.isSharePrcId(freeEnt.getProdPrcId(), regionCode) ? "0" : "1";
                    }

                    FreeGprsDetailEntity prcDetailEnt = new FreeGprsDetailEntity();
                    prcDetailEnt.setPrcNum(1);
                    prcDetailEnt.setPrcId(prcId);
                    prcDetailEnt.setPrcName(freeEnt.getProdPrcName());
                    prcDetailEnt.setLongGprsTotal(freeEnt.getLongTotal() + freeEnt.getLongLastTotal());
                    prcDetailEnt.setLongGprsUsed(freeEnt.getLongUsed() + freeEnt.getLongLastUsed());
                    prcDetailEnt.setProductType(""); //
                    prcDetailEnt.setRateType(unitCode.equals("3") ? "2" : (unitCode.equals("4") ? "1" : "-")); //1: 按流量；2：按时长
                    String limitType = freeEnt.getLimitType();
                    prcDetailEnt.setUseType(limitType.equals("02") ? "1" : (limitType.equals("01") ? "2" : "0"));
                    prcDetailEnt.setNetType(""); //TODO
                    prcDetailEnt.setSendType(sendType);
                    prcDetailEnt.setShareType(shareType); //0:可共享；1：不可共享
                    prcDetailEnt.setCarryType((carryFlag == 1) ? "0" : "1"); //0:结转；1：非结转
                    prcDetailEnt.setCumulateType("0"); //0：按月累计
                    prcDetailEnt.setBeginDate(""); //按月累计时，返回空
                    prcDetailEnt.setEndDate("");  //按月累计时，返回空

                    indexMap.put(prcId, prcDetailEnt);
                    numMap.put(prcId, 1);
                }


            } //:: end for
        } //::end if

        List<FreeGprsDetailEntity> detailList = new ArrayList<>();
        for (String key : indexMap.keySet()) {
            FreeGprsDetailEntity detailEnt = indexMap.get(key);
            detailEnt.setPrcNum(numMap.get(key));
            detailEnt.setGprsTotal(String.format("%d", detailEnt.getLongGprsTotal()));
            detailEnt.setGprsUsed(String.format("%d", detailEnt.getLongGprsUsed()));

            detailList.add(detailEnt);
        }


        //拼接出参
        outDto.setRetCode(retCode);
        outDto.setRetMsg(retMsg);
        outDto.setPhoneNo(phoneNo);

        outDto.setGprsTotal(String.format("%d", gprsShouldTotal));
        outDto.setGprsUsed(String.format("%d", gprsUsedTotal));

        outDto.setDetailList(detailList);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IBillAccount getBillAccount() {
        return billAccount;
    }

    public void setBillAccount(IBillAccount billAccount) {
        this.billAccount = billAccount;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }
}
