package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.Appendix1LevelBill;
import com.sitech.acctmgr.atom.domains.bill.ConDetailAppendixDispEntity;
import com.sitech.acctmgr.atom.domains.bill.SpDispEntity;
import com.sitech.acctmgr.atom.domains.free.Free2DispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

@SuppressWarnings("serial")
public class QryBillApxOutDTO extends CommonOutDTO {

    @ParamDesc(path = "PCAS_09.PCAS_09_01_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "套餐及固定费明细", memo = "非List")
    private Appendix1LevelBill billInfo1 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_02_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "语音通信费明细", memo = "")
    private Appendix1LevelBill billInfo2 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_03_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "可视电话通信费", memo = "")
    private Appendix1LevelBill billInfo3 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_04_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "上网费明细", memo = "")
    private Appendix1LevelBill billInfo4 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_05_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "短彩信费明细", memo = "")
    private Appendix1LevelBill billInfo5 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_06_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "增值业务费明细", memo = "")
    private Appendix1LevelBill billInfo6 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_08_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "集团业务费", memo = "")
    private Appendix1LevelBill billInfo8 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_09_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "代收费业务费明细", memo = "")
    private Appendix1LevelBill billInfo9 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.PCAS_09_10_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "其他费明细", memo = "")
    private Appendix1LevelBill billInfo10 = new Appendix1LevelBill();

    @ParamDesc(path = "PCAS_09.TOTAL_SHOULD_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "总消费金额", memo = "单位：分")
    private long totalShouldPay;

    @ParamDesc(path = "PCAS_09.TOTAL_FAVOUR_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "总减免金额", memo = "单位：分")
    private long totalFavourFee;

    @ParamDesc(path = "PCAS_09.TOTAL_REAL_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "总帐单实收", memo = "单位：分")
    private long totalRealFee;

    @ParamDesc(path = "PCAS_09.TOTAL_CUST_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "客户付费支付总金额", memo = "单位：分")
    private long totalCustPay;

    @ParamDesc(path = "PCAS_09.TOTAL_MOBILE_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "移动赠送支付总金额", memo = "单位：分")
    private long totalMobilePay;

    @ParamDesc(path = "PCAS_10.PCAS_10_LIST", cons = ConsType.QUES, len = "", type = "complex", desc = "通信量使用情况", memo = "List，子节点流量单位均为KB")
    private List<Free2DispEntity> freeList = null;

    @ParamDesc(path = "PCAS_11.PCAS_11_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "帐户入帐信息", memo = "非List")
    private ConDetailAppendixDispEntity incomeInfo;

    @ParamDesc(path = "PCAS_12.PCAS_12_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "SP信息", memo = "非List")
    private SpDispEntity spInfo;

    @Override
    public MBean encode() {
        MBean bean = super.encode();

        bean.setRoot(getPathByProperName("billInfo1"), billInfo1);
        bean.setRoot(getPathByProperName("billInfo2"), billInfo2);
        bean.setRoot(getPathByProperName("billInfo3"), billInfo3);
        bean.setRoot(getPathByProperName("billInfo4"), billInfo4);
        bean.setRoot(getPathByProperName("billInfo5"), billInfo5);
        bean.setRoot(getPathByProperName("billInfo6"), billInfo6);
        bean.setRoot(getPathByProperName("billInfo8"), billInfo8);
        bean.setRoot(getPathByProperName("billInfo9"), billInfo9);
        bean.setRoot(getPathByProperName("billInfo10"), billInfo10);

        bean.setRoot(getPathByProperName("totalShouldPay"), totalShouldPay);
        bean.setRoot(getPathByProperName("totalFavourFee"), totalFavourFee);
        bean.setRoot(getPathByProperName("totalRealFee"), totalRealFee);
        bean.setRoot(getPathByProperName("totalCustPay"), totalCustPay);
        bean.setRoot(getPathByProperName("totalMobilePay"), totalMobilePay);

        bean.setRoot(getPathByProperName("freeList"), freeList);

        bean.setRoot(getPathByProperName("incomeInfo"), incomeInfo);

        bean.setRoot(getPathByProperName("spInfo"), spInfo);

        return bean;
    }

    public Appendix1LevelBill getBillInfo1() {
        return billInfo1;
    }

    public void setBillInfo1(Appendix1LevelBill billInfo1) {
        this.billInfo1 = billInfo1;
    }

    public Appendix1LevelBill getBillInfo2() {
        return billInfo2;
    }

    public void setBillInfo2(Appendix1LevelBill billInfo2) {
        this.billInfo2 = billInfo2;
    }

    public Appendix1LevelBill getBillInfo3() {
        return billInfo3;
    }

    public void setBillInfo3(Appendix1LevelBill billInfo3) {
        this.billInfo3 = billInfo3;
    }

    public Appendix1LevelBill getBillInfo4() {
        return billInfo4;
    }

    public void setBillInfo4(Appendix1LevelBill billInfo4) {
        this.billInfo4 = billInfo4;
    }

    public Appendix1LevelBill getBillInfo5() {
        return billInfo5;
    }

    public void setBillInfo5(Appendix1LevelBill billInfo5) {
        this.billInfo5 = billInfo5;
    }

    public Appendix1LevelBill getBillInfo6() {
        return billInfo6;
    }

    public void setBillInfo6(Appendix1LevelBill billInfo6) {
        this.billInfo6 = billInfo6;
    }

    public Appendix1LevelBill getBillInfo8() {
        return billInfo8;
    }

    public void setBillInfo8(Appendix1LevelBill billInfo8) {
        this.billInfo8 = billInfo8;
    }

    public Appendix1LevelBill getBillInfo9() {
        return billInfo9;
    }

    public void setBillInfo9(Appendix1LevelBill billInfo9) {
        this.billInfo9 = billInfo9;
    }

    public Appendix1LevelBill getBillInfo10() {
        return billInfo10;
    }

    public void setBillInfo10(Appendix1LevelBill billInfo10) {
        this.billInfo10 = billInfo10;
    }

    public long getTotalShouldPay() {
        return totalShouldPay;
    }

    public void setTotalShouldPay(long totalShouldPay) {
        this.totalShouldPay = totalShouldPay;
    }

    public long getTotalFavourFee() {
        return totalFavourFee;
    }

    public void setTotalFavourFee(long totalFavourFee) {
        this.totalFavourFee = totalFavourFee;
    }

    public long getTotalRealFee() {
        return totalRealFee;
    }

    public void setTotalRealFee(long totalRealFee) {
        this.totalRealFee = totalRealFee;
    }

    public long getTotalCustPay() {
        return totalCustPay;
    }

    public void setTotalCustPay(long totalCustPay) {
        this.totalCustPay = totalCustPay;
    }

    public long getTotalMobilePay() {
        return totalMobilePay;
    }

    public void setTotalMobilePay(long totalMobilePay) {
        this.totalMobilePay = totalMobilePay;
    }

    public ConDetailAppendixDispEntity getIncomeInfo() {
        return incomeInfo;
    }

    public void setIncomeInfo(ConDetailAppendixDispEntity incomeInfo) {
        this.incomeInfo = incomeInfo;
    }

    public List<Free2DispEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<Free2DispEntity> freeList) {
        this.freeList = freeList;
    }

    public SpDispEntity getSpInfo() {
        return spInfo;
    }

    public void setSpInfo(SpDispEntity spInfo) {
        this.spInfo = spInfo;
    }
}
