package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/11/4.
 * 帐单附录页展示1级展示的数据实体
 */
public class Appendix1LevelBill implements Serializable {
    @JSONField(name = "ITEM_NAME")
    @ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, len = "64", type = "string", desc = "帐单大类名称", memo = "")
    private String itemName;

    @JSONField(name = "ITEM_ID")
    @ParamDesc(path = "ITEM_ID", cons = ConsType.CT001, len = "10", type = "string", desc = "一级帐目项ID", memo = "")
    private String itemId;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "小计消费金额", memo = "")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "小计优惠金额", memo = "")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "小计账单实收", memo = "")
    private long realFee;

    @JSONField(name = "CUST_PAY")
    @ParamDesc(path = "CUST_PAY", cons = ConsType.CT001, len = "", type = "long", desc = "小计客户付费支付", memo = "")
    private long custPay;

    @JSONField(name = "MOBILE_PAY")
    @ParamDesc(path = "MOBILE_PAY", cons = ConsType.CT001, len = "", type = "long", desc = "小计移动赠送支付", memo = "")
    private long mobilePay;

    @JSONField(name = "DETAIL_INFO")
    @ParamDesc(path = "DETAIL_INFO", cons = ConsType.CT001, len = "", type = "complex", desc = "大类下帐目项明细列表", memo = "")
    private List<AppendixBill> detailList;

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
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

    public List<AppendixBill> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<AppendixBill> detailList) {
        this.detailList = detailList;
    }
}
