package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：对应收费用、优惠费用、实收费用作封装
 * Created by wangyla on 2016/7/27.
 */
public class BillFeeEntity implements Serializable {
    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "20", desc = "应收", memo = "略")
    private long shouldPay;
    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "优惠", memo = "略")
    private long favourFee;
    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "实收", memo = "略")
    private long realFee;
    @JSONField(name = "MOBILE_PAY")
    @ParamDesc(path = "MOBILE_PAY", cons = ConsType.CT001, type = "long", len = "20", desc = "移动赠费支付", memo = "略")
    private long mobilePay;
    @JSONField(name = "CUST_PAY")
    @ParamDesc(path = "CUST_PAY", cons = ConsType.CT001, type = "long", len = "20", desc = "客户付费支付", memo = "略")
    private long custPay;

    public BillFeeEntity() {
        super();
    }

    public BillFeeEntity(long shouldPay, long favourFee, long realFee, long mobilePay, long custPay) {
        this.shouldPay = shouldPay;
        this.favourFee = favourFee;
        this.realFee = realFee;
        this.mobilePay = mobilePay;
        this.custPay = custPay;
    }

    public BillFeeEntity add(BillFeeEntity billEnt) {
        BillFeeEntity outEnt = new BillFeeEntity();
        outEnt.setShouldPay(this.shouldPay + billEnt.getShouldPay());
        outEnt.setFavourFee(this.favourFee + billEnt.getFavourFee());
        outEnt.setRealFee(this.realFee + billEnt.getRealFee());
        outEnt.setMobilePay(this.mobilePay + billEnt.getMobilePay());
        outEnt.setCustPay(this.custPay + billEnt.getCustPay());
        return outEnt;
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

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
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

    @Override
    public String toString() {
        return "BillFeeEntity{" +
                "shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", mobilePay=" + mobilePay +
                ", custPay=" + custPay +
                '}';
    }
}
