package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/4/12.
 */
public class FeeCodeBillEntity implements Serializable {
    @JSONField(name = "FEE_CODE")
    @ParamDesc(path = "FEE_CODE", cons = ConsType.CT001, type = "String", len = "14", desc = "一级帐目项组代码", memo = "略")
    private String feeCode;

    @JSONField(name = "FEE_CODE_NAME")
    @ParamDesc(path = "FEE_CODE_NAME", cons = ConsType.CT001, type = "String", len = "50", desc = "一级帐目项名称", memo = "略")
    private String feeCodeName;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "略")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "略")
    private long favourFee;

    @JSONField(serialize = false)
    private long delayFee;
    @JSONField(serialize = false)
    private long oweFee;

    public String getFeeCode() {
        return feeCode;
    }

    public void setFeeCode(String feeCode) {
        this.feeCode = feeCode;
    }

    public String getFeeCodeName() {
        return feeCodeName;
    }

    public void setFeeCodeName(String feeCodeName) {
        this.feeCodeName = feeCodeName;
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

    public long getDelayFee() {
        return delayFee;
    }

    public void setDelayFee(long delayFee) {
        this.delayFee = delayFee;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    @Override
    public String toString() {
        return "FeeCodeBillEntity{" +
                "feeCode='" + feeCode + '\'' +
                ", feeCodeName='" + feeCodeName + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                '}';
    }
}
