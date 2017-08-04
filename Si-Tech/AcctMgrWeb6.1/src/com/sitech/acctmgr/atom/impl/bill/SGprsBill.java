package com.sitech.acctmgr.atom.impl.bill;

import static org.apache.commons.collections.MapUtils.getObject;
import static org.apache.commons.collections.MapUtils.getString;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.bill.BillFeeEntity;
import com.sitech.acctmgr.atom.domains.bill.BillFeeInfo2;
import com.sitech.acctmgr.atom.domains.bill.SchemeInfoEntity;
import com.sitech.acctmgr.atom.domains.bill.TrafficBillEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.SGPRSBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SGPRSBillQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.bill.IGprsBill;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/14.
 */
@ParamTypes({@ParamType(c = SGPRSBillQueryInDTO.class, m = "query", oc = SGPRSBillQueryOutDTO.class)})
public class SGprsBill extends AcctMgrBaseService implements IGprsBill {

    private IUser user;
    private IBillDisplayer billDisplayer;
    private IFreeDisplayer freeDisplayer;

    @Override
    public OutDTO query(InDTO inParam) {
        SGPRSBillQueryInDTO inDTO = (SGPRSBillQueryInDTO) inParam;

        UserInfoEntity userInfo = user.getUserEntity(null, inDTO.getPhoneNo(), null, true);
        BillFeeInfo2 billFee = billDisplayer.getBillFee2(userInfo.getIdNo(), inDTO.getYearMonth());
        BillFeeEntity mealFeeInfo = billFee.getFixedFee(); //套餐及固定费
        BillFeeEntity netFeeInfo = billFee.getNetFee(); //上网费

        Map<String, Object> trafficMap = this.getTrafficBill(inDTO.getPhoneNo(), inDTO.getYearMonth());

        Object obj = getObject(trafficMap, "MEAL_TRAFFIC_LIST");
        List<TrafficBillEntity> mealTrafficList = null;
        if (obj instanceof List) {
            mealTrafficList = (List<TrafficBillEntity>) obj;
        }

        //TODO 获取推荐资费
        //TODO 判断推荐资费为附加资费时，新增节点返回推荐值；否则节点返回空
        SchemeInfoEntity schemaInfoEnt = billDisplayer.getGprsSchemeInfo(inDTO.getPhoneNo(), inDTO.getYearMonth());
        
        String tips = schemaInfoEnt.getTips();
        String addedTips = schemaInfoEnt.getAddedTips();
        String prcId = schemaInfoEnt.getPrcId();
        String prcSchemeInfo = schemaInfoEnt.getPrcSchemeInfo();

        SGPRSBillQueryOutDTO outDTO = new SGPRSBillQueryOutDTO();
        //TODO 后续需要和用户沟通套餐内流量帐单用套餐费用替换的认可度
        outDTO.setTotalShould(mealFeeInfo.getShouldPay());
        outDTO.setTotalFavour(mealFeeInfo.getFavourFee());
        outDTO.setTotalFee(mealFeeInfo.getRealFee());
        outDTO.setOutGprsTotalFee(netFeeInfo.getRealFee());
        outDTO.setOutGprsTotal(getString(trafficMap, "OUT_MEAL_GRPS"));
        outDTO.setUnitName(getString(trafficMap,"UNIT_NAME"));
        outDTO.setMealBillList(mealTrafficList);
        outDTO.setAddedTips(addedTips);
        outDTO.setPrcId(prcId);
        outDTO.setPrcSchemeInfo(prcSchemeInfo);
        outDTO.setTips(tips);

        log.debug("outDTO=" + outDTO.toJson());
        return outDTO;
    }

    private Map<String, Object> getTrafficBill(String phoneNo, int queryYm) {
        List<FreeMinBill> gprsBillList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "3"); //GPRS
        List<FreeMinBill> wlanBillList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "5"); //WLAN
        //存放所有流量帐单明细，以下操作均针对所有流量优惠信息//
        List<FreeMinBill> trafficBillList = new ArrayList<>();
        trafficBillList.addAll(gprsBillList);
        trafficBillList.addAll(wlanBillList);

        /*套餐内流量明细列表（含wlan和gprs）*/
        List<TrafficBillEntity> outTrafficList = new ArrayList<>();
        HashMap<String, Object> outMap = new HashMap<>();

        /**
         *  整体只为2部分内容：a)套餐外流量总量；b)套餐内流量明细。
         * 1、所有优惠信息均需要展示使用比例
         * 2、展示多人共享标识
         * 3、展示月租费
         * 4、需要获取到套餐外gprs流量
         *
         */

        long outMealGprsTotal = 0;
        String mealUsedTmp;
        long wlanMealUsedTmp = 0;
        TrafficBillEntity trafficEnt;
        for (FreeMinBill freeLine : trafficBillList) {
            trafficEnt = null;
            String busiCode = freeLine.getBusiCode();
            if (busiCode.equals("3")) {
                /*套餐外流量*/
                if (freeLine.getFavType().equals("0002")) {
                    outMealGprsTotal += freeLine.getLongUsed();
                } else {
                    /**
                     * 套餐内明细列表信息
                     */
                    if (freeLine.getLongTotal() < freeLine.getLongUsed()) {
                        mealUsedTmp = String.format("%.2f", freeLine.getLongTotal() * 1.0 / 1024);
                    } else {
                        mealUsedTmp = String.format("%.2f", freeLine.getLongUsed() * 1.0 / 1024);
                    }

                    if (freeLine.getFavCode().equals("e")) { //集团个人共享
                        trafficEnt = new TrafficBillEntity();
                        trafficEnt.setBusiCode(busiCode);
                        trafficEnt.setTotal("0.00");
                        trafficEnt.setCurrent(mealUsedTmp);
                        trafficEnt.setUnit(freeLine.getUnitCode());
                        trafficEnt.setUnitName("MB");
                        trafficEnt.setPercent("");
                        trafficEnt.setShareFlag("Y");
                        trafficEnt.setProdPrcIdName(freeLine.getProdPrcName());
                    } else if (!freeLine.getFavCode().equals("f")) {
                        trafficEnt = new TrafficBillEntity();
                        trafficEnt.setBusiCode(busiCode);
                        trafficEnt.setTotal(String.format("%.2f", freeLine.getLongTotal() * 1.0 / 1024));
                        trafficEnt.setCurrent(mealUsedTmp);
                        trafficEnt.setUnit(freeLine.getUnitCode());
                        trafficEnt.setUnitName("MB");
                        trafficEnt.setPercent(String.format("%.2f%%", freeLine.getLongUsed() * 100.0 / freeLine.getLongTotal()));
                        trafficEnt.setShareFlag("N");
                        trafficEnt.setProdPrcIdName(freeLine.getProdPrcName());

                        //结转流量单独展示
                        if (freeLine.getLongLastTotal() > 0) {
                            TrafficBillEntity trafficLastEnt = new TrafficBillEntity();
                            trafficLastEnt.setBusiCode(busiCode);
                            trafficLastEnt.setTotal(String.format("%.2f", freeLine.getLongLastTotal() * 1.0 / 1024));
                            trafficLastEnt.setCurrent(String.format("%.2f", freeLine.getLongLastUsed() * 1.0 / 1024));
                            trafficLastEnt.setUnit(freeLine.getUnitCode());
                            trafficLastEnt.setUnitName("MB");
                            trafficLastEnt.setPercent(String.format("%.2f%%", freeLine.getLongLastUsed() * 100.0 / freeLine.getLongLastTotal()));
                            trafficLastEnt.setShareFlag("N");
                            trafficLastEnt.setProdPrcIdName(freeLine.getProdPrcName() + "上月结转流量");
                            outTrafficList.add(trafficLastEnt);
                        }
                    }

                }

            }

            if (busiCode.equals("5")) {

                if (freeLine.getFavType().equals("0003")) {
                    continue;
                }

                if (freeLine.getUnitCode().equals("3")) {
                    if (freeLine.getLongTotal() < freeLine.getLongUsed()) {
                        wlanMealUsedTmp = freeLine.getLongTotal();
                    } else {
                        wlanMealUsedTmp = freeLine.getLongUsed();
                    }

                    trafficEnt = new TrafficBillEntity();
                    trafficEnt.setBusiCode(busiCode);
                    trafficEnt.setTotal(freeLine.getTotal());
                    trafficEnt.setCurrent(String.format("%d", wlanMealUsedTmp));
                    trafficEnt.setUnit(freeLine.getUnitCode());
                    trafficEnt.setUnitName(freeLine.getUnitName());
                    trafficEnt.setPercent(String.format("%.2f%%", freeLine.getLongUsed() * 100.0 / freeLine.getLongTotal()));
                    trafficEnt.setShareFlag("N");
                    trafficEnt.setProdPrcIdName(freeLine.getProdPrcName());
                }

                if (freeLine.getUnitCode().equals("4")) {
                    if (freeLine.getLongTotal() < freeLine.getLongUsed()) {
                        mealUsedTmp = String.format("%.2f", freeLine.getLongTotal() * 1.0 / 1024);
                    } else {
                        mealUsedTmp = String.format("%.2f", freeLine.getLongUsed() * 1.0 / 1024);
                    }

                    trafficEnt = new TrafficBillEntity();
                    trafficEnt.setBusiCode(busiCode);
                    trafficEnt.setTotal(String.format("%.2f", freeLine.getLongTotal() * 1.0 / 1024));
                    trafficEnt.setCurrent(mealUsedTmp);
                    trafficEnt.setUnit(freeLine.getUnitCode());
                    trafficEnt.setUnitName("MB");
                    trafficEnt.setPercent(String.format("%.2f%%", freeLine.getLongUsed() * 100.0 / freeLine.getLongTotal()));
                    trafficEnt.setShareFlag("N");
                    trafficEnt.setProdPrcIdName(freeLine.getProdPrcName());
                }

            }

            if (trafficEnt != null) {
                outTrafficList.add(trafficEnt);
            }

        }

        outMap.put("OUT_MEAL_GRPS", String.format("%d", outMealGprsTotal));
        outMap.put("UNIT_NAME", "MB");
        outMap.put("MEAL_TRAFFIC_LIST", outTrafficList);

        return outMap;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IBillDisplayer getBillDisplayer() {
        return billDisplayer;
    }

    public void setBillDisplayer(IBillDisplayer billDisplayer) {
        this.billDisplayer = billDisplayer;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }
}
