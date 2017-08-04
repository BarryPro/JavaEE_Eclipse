package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/12/27.
 */
public class BankBillDispEntity implements Serializable {
    @JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, type = "int", len = "6", desc = "查询帐期", memo = "YYYYMM")
    private int yearMonth;
    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "略")
    private long shouldPay;
    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "略")
    private long favourFee;
    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "14", desc = "划拨金额", memo = "略")
    private long payedPrepay;
    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "14", desc = "新交款金额", memo = "略")
    private long payedLater;
    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "欠费", memo = "略")
    private long oweFee;
    @JSONField(name = "DELAY_FEE")
    @ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "滞纳金费用", memo = "略")
    private long delayFee;

    @JSONField(name = "FEE1")
    @ParamDesc(path = "FEE1", cons = ConsType.CT001, len = "14", type = "long", desc = "月租费", memo = "1")
    private long fee1;
    @JSONField(name = "FEE2")
    @ParamDesc(path = "FEE2", cons = ConsType.CT001, len = "14", type = "long", desc = "特服费", memo = "2")
    private long fee2;
    @JSONField(name = "FEE3")
    @ParamDesc(path = "FEE3", cons = ConsType.CT001, len = "14", type = "long", desc = "本地通话", memo = "3")
    private long fee3;
    @JSONField(name = "FEE4")
    @ParamDesc(path = "FEE4", cons = ConsType.CT001, len = "14", type = "long", desc = "漫游长途", memo = "4")
    private long fee4;
    @JSONField(name = "FEE5")
    @ParamDesc(path = "FEE5", cons = ConsType.CT001, len = "14", type = "long", desc = "省内长途", memo = "5")
    private long fee5;
    @JSONField(name = "FEE6")
    @ParamDesc(path = "FEE6", cons = ConsType.CT001, len = "14", type = "long", desc = "国内/国际/港澳长途", memo = "6")
    private long fee6;
    @JSONField(name = "FEE7")
    @ParamDesc(path = "FEE7", cons = ConsType.CT001, len = "14", type = "long", desc = "手续费", memo = "7")
    private long fee7;
    @JSONField(name = "FEE8")
    @ParamDesc(path = "FEE8", cons = ConsType.CT001, len = "14", type = "long", desc = "附加费", memo = "8")
    private long fee8;
    @JSONField(name = "FEE9")
    @ParamDesc(path = "FEE9", cons = ConsType.CT001, len = "14", type = "long", desc = "信息费", memo = "9")
    private long fee9;
    @JSONField(name = "FEE10")
    @ParamDesc(path = "FEE10", cons = ConsType.CT001, len = "14", type = "long", desc = "农话费", memo = "10")
    private long fee10;
    @JSONField(name = "FEE11")
    @ParamDesc(path = "FEE11", cons = ConsType.CT001, len = "14", type = "long", desc = "补收费", memo = "11")
    private long fee11;

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
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

    public long getPayedPrepay() {
        return payedPrepay;
    }

    public void setPayedPrepay(long payedPrepay) {
        this.payedPrepay = payedPrepay;
    }

    public long getPayedLater() {
        return payedLater;
    }

    public void setPayedLater(long payedLater) {
        this.payedLater = payedLater;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    public long getDelayFee() {
        return delayFee;
    }

    public void setDelayFee(long delayFee) {
        this.delayFee = delayFee;
    }

    public long getFee1() {
        return fee1;
    }

    public void setFee1(long fee1) {
        this.fee1 = fee1;
    }

    public long getFee2() {
        return fee2;
    }

    public void setFee2(long fee2) {
        this.fee2 = fee2;
    }

    public long getFee3() {
        return fee3;
    }

    public void setFee3(long fee3) {
        this.fee3 = fee3;
    }

    public long getFee4() {
        return fee4;
    }

    public void setFee4(long fee4) {
        this.fee4 = fee4;
    }

    public long getFee5() {
        return fee5;
    }

    public void setFee5(long fee5) {
        this.fee5 = fee5;
    }

    public long getFee6() {
        return fee6;
    }

    public void setFee6(long fee6) {
        this.fee6 = fee6;
    }

    public long getFee7() {
        return fee7;
    }

    public void setFee7(long fee7) {
        this.fee7 = fee7;
    }

    public long getFee8() {
        return fee8;
    }

    public void setFee8(long fee8) {
        this.fee8 = fee8;
    }

    public long getFee9() {
        return fee9;
    }

    public void setFee9(long fee9) {
        this.fee9 = fee9;
    }

    public long getFee10() {
        return fee10;
    }

    public void setFee10(long fee10) {
        this.fee10 = fee10;
    }

    public long getFee11() {
        return fee11;
    }

    public void setFee11(long fee11) {
        this.fee11 = fee11;
    }

    @Override
    public String toString() {
        return "BankBillDispEntity{" +
                "yearMonth=" + yearMonth +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", oweFee=" + oweFee +
                ", delayFee=" + delayFee +
                ", fee1=" + fee1 +
                ", fee2=" + fee2 +
                ", fee3=" + fee3 +
                ", fee4=" + fee4 +
                ", fee5=" + fee5 +
                ", fee6=" + fee6 +
                ", fee7=" + fee7 +
                ", fee8=" + fee8 +
                ", fee9=" + fee9 +
                ", fee10=" + fee10 +
                ", fee11=" + fee11 +
                '}';
    }
}
