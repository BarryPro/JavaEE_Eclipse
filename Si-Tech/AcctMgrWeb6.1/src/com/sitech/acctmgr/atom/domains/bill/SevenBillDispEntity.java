package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/6/22.
 */
public class SevenBillDispEntity implements Serializable{

	private static final long serialVersionUID = 1L;

	@JSONField(name = "DETAIL_LIST")
    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.STAR, type = "complex", len = "", desc = "三级帐单明细列表", memo = "List")
    private List<BillDispEntity> detailList;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类应收", memo = "单位：分")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类优惠", memo = "单位：分")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类实收", memo = "单位：分")
    private long realFee;

    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类划拨冲销金额", memo = "单位：分")
    private long payedPrepay;

    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类缴费冲销金额", memo = "单位：分")
    private long payedLater;

    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "分类大类欠费", memo = "单位：分")
    private long oweFee;

    @JSONField(name = "PAYED_STATUS_NAME")
    @ParamDesc(path = "PAYED_STATUS_NAME", cons = ConsType.CT001, type = "string", len = "5", desc = "帐单状态", memo = "略")
    private String payedStatusName; /*欠费为未缴；非欠费为已缴*/

    @JSONField(name = "SEVEN_ITEM_ID")
    @ParamDesc(path = "SEVEN_ITEM_ID", cons = ConsType.CT001, type = "string", len = "10", desc = "大类代码", memo = "略")
    private String itemId; /*七大类ID*/

    @JSONField(name = "SEVEN_ITEM_NAME")
    @ParamDesc(path = "SEVEN_ITEM_NAME", cons = ConsType.CT001, type = "string", len = "40", desc = "大类名称", memo = "略")
    private String itemName; /*七大类名称*/

    public List<BillDispEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<BillDispEntity> detailList) {
        this.detailList = detailList;
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

    public String getPayedStatusName() {
        return payedStatusName;
    }

    public void setPayedStatusName(String payedStatusName) {
        this.payedStatusName = payedStatusName;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    @Override
    public String toString() {
        return "SevenBillDispEntity{" +
                "detailList=" + detailList +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", oweFee=" + oweFee +
                ", payedStatusName='" + payedStatusName + '\'' +
                ", itemId='" + itemId + '\'' +
                ", itemName='" + itemName + '\'' +
                '}';
    }
}
