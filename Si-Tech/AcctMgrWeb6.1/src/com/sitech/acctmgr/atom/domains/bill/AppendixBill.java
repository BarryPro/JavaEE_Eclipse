package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * @author 附录页帐单明细展示
 */
public class AppendixBill {
    public AppendixBill() {
    }

    @JSONField(name = "PARENT_ITEM_ID")
    @ParamDesc(path = "PARENT_ITEM_ID", cons = ConsType.CT001, len = "10", type = "string", desc = "一级帐目项ID（帐单大类）", memo = "")
    private String parentItemId;

    @JSONField(name = "ITEM_NAME")
    @ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, len = "64", type = "string", desc = "账单项名称", memo = "")
    private String itemName;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "消费金额", memo = "")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "优惠金额", memo = "")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "账单实收", memo = "")
    private long realFee;

    @JSONField(name = "CUST_PAY")
    @ParamDesc(path = "CUST_PAY", cons = ConsType.CT001, len = "", type = "long", desc = "客户付费支付", memo = "")
    private long custPay;

    @JSONField(name = "MOBILE_PAY")
    @ParamDesc(path = "MOBILE_PAY", cons = ConsType.CT001, len = "", type = "long", desc = "移动赠送支付", memo = "")
    private long mobilePay;

    @JSONField(name = "ITEM_ID")
    @ParamDesc(path = "ITEM_ID", cons = ConsType.CT001, len = "10", type = "string", desc = "账单项", memo = "")
    private String itemId;

    public String getParentItemId() {
        return parentItemId;
    }

    public void setParentItemId(String parentItemId) {
        this.parentItemId = parentItemId;
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

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public long getCustPay() {
        return custPay;
    }

    public void setCustPay(long custPay) {
        this.custPay = custPay;
    }

    public long getMobilePay() {
        return mobilePay;
    }

    public void setMobilePay(long mobilePay) {
        this.mobilePay = mobilePay;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    @Override
    public String toString() {
        return "AppendixBill{" +
                "parentItemId='" + parentItemId + '\'' +
                ", itemName='" + itemName + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", custPay=" + custPay +
                ", mobilePay=" + mobilePay +
                ", itemId='" + itemId + '\'' +
                '}';
    }
}
