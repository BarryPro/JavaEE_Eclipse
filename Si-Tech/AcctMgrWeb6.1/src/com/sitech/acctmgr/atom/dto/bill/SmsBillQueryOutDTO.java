package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.SmsBillFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/21.
 */
public class SmsBillQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "BRAND_NAME", cons = ConsType.CT001, type = "String", len = "20", desc = "品牌名称", memo = "略")
    private String brandName;

    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, type = "int", len = "6", desc = "计费帐期", memo = "略")
    private int yearMonth;

    @ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "实际消费金额", memo = "单位：分")
    private long totalFee;

    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "单位：分")
    private long shouldPay;

    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "单位：分")
    private long favourFee;

    @ParamDesc(path = "MOBILE_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "移动付费总金额", memo = "单位：分")
    private long mobilePay;

    @ParamDesc(path = "CUST_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "客户付费总金额", memo = "单位：分")
    private long custPay;

    @ParamDesc(path = "LOWEST_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "最低消费金额", memo = "单位：分")
    private long lowestFee;

    @ParamDesc(path = "TIP_NOTES", cons = ConsType.CT001, type = "String", len = "250", desc = "温馨提示", memo = "略")
    private String tipNotes;

    @ParamDesc(path = "FEE_LIST", cons = ConsType.CT001, type = "complex", len = "", desc = "费用信息", memo = "List")
    List<SmsBillFeeEntity> feeList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("brandName"), brandName);
        result.setRoot(getPathByProperName("yearMonth"), yearMonth);
        result.setRoot(getPathByProperName("totalFee"), totalFee);
        result.setRoot(getPathByProperName("shouldPay"), shouldPay);
        result.setRoot(getPathByProperName("favourFee"), favourFee);
        result.setRoot(getPathByProperName("mobilePay"), mobilePay);
        result.setRoot(getPathByProperName("custPay"), custPay);
        result.setRoot(getPathByProperName("lowestFee"), lowestFee);
        result.setRoot(getPathByProperName("tipNotes"), tipNotes);
        result.setRoot(getPathByProperName("feeList"), feeList);

        return result;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

    public long getShouldPay() {
        return shouldPay;
    }

    public void setShouldPay(long shouldPay) {
        this.shouldPay = shouldPay;
    }

    public long getFavourFee() {
        return favourFee;
    }

    public void setFavourFee(long favourFee) {
        this.favourFee = favourFee;
    }

    public long getMobilePay() {
        return mobilePay;
    }

    public void setMobilePay(long mobilePay) {
        this.mobilePay = mobilePay;
    }

    public long getCustPay() {
        return custPay;
    }

    public void setCustPay(long custPay) {
        this.custPay = custPay;
    }

    public long getLowestFee() {
        return lowestFee;
    }

    public void setLowestFee(long lowestFee) {
        this.lowestFee = lowestFee;
    }

    public String getTipNotes() {
        return tipNotes;
    }

    public void setTipNotes(String tipNotes) {
        this.tipNotes = tipNotes;
    }

    public List<SmsBillFeeEntity> getFeeList() {
        return feeList;
    }

    public void setFeeList(List<SmsBillFeeEntity> feeList) {
        this.feeList = feeList;
    }
}
