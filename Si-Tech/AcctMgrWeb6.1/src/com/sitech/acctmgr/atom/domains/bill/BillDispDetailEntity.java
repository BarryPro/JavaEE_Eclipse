package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/11/23.
 * 功能：帐单打印费用实体
 */
public class BillDispDetailEntity implements Serializable {
    @JSONField(name = "ACCT_ITEM_CODE")
    @ParamDesc(path = "ACCT_ITEM_CODE", cons = ConsType.CT001, type = "string", len = "10", desc = "账目项名称", memo = "")
    private String acctItemCode;

    @JSONField(name = "ITEM_NAME")
    @ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, type = "string", len = "60", desc = "账目项名称", memo = "")
    private String itemName;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "")
    private long favourFee;

    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "14", desc = "预存划拨冲销金额", memo = "")
    private long payedPrepay;

    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "14", desc = "缴费冲销金额", memo = "")
    private long payedLater;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "", desc = "实收费用", memo = "")
    private long realFee;

    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "欠费金额", memo = "")
    private long oweFee;

    @JSONField(serialize = false)
    private int billBegin; /*账期开始日*/
    @JSONField(serialize = false)
    private int billEnd; /*账期结束日*/


    public String getAcctItemCode() {
        return acctItemCode;
    }

    public void setAcctItemCode(String acctItemCode) {
        this.acctItemCode = acctItemCode;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
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

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    public int getBillBegin() {
        return billBegin;
    }

    public void setBillBegin(int billBegin) {
        this.billBegin = billBegin;
    }

    public int getBillEnd() {
        return billEnd;
    }

    public void setBillEnd(int billEnd) {
        this.billEnd = billEnd;
    }

    @Override
    public String toString() {
        return "BillDispDetailEntity{" +
                "acctItemCode='" + acctItemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", realFee=" + realFee +
                ", oweFee=" + oweFee +
                ", billBegin=" + billBegin +
                ", billEnd=" + billEnd +
                '}';
    }
}
