package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/6.
 */
public class BillDisp13LevelEntity implements Serializable {

    @JSONField(name = "ITEM_ID")
    @ParamDesc(path = "ITEM_ID", cons = ConsType.CT001, len = "10", type = "String", desc = "一级帐目项代码", memo = "")
    private String itemId;

    @JSONField(name = "ITEM_NAME")
    @ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, len = "100", type = "String", desc = "一级帐目项名称", memo = "")
    private String itemName;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "一级应收费用", memo = "")
    private long shouldPay;
    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "一级优惠费用", memo = "")
    private long favourFee;
    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "一级实收费用", memo = "")
    private long realFee; //实收费用 shouldPay - favourFee

    @JSONField(name = "DETAIL_3_LIST")
    @ParamDesc(path = "DETAIL_3_LIST", cons = ConsType.CT001, len = "", type = "complex", desc = "三级帐单列表", memo = "")
    private List<BillDisp3LevelEntity> detailList;

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

    public List<BillDisp3LevelEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<BillDisp3LevelEntity> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "BillDisp13LevelEntity{" +
                "itemId='" + itemId + '\'' +
                ", itemName='" + itemName + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", detailList=" + detailList +
                '}';
    }
}
