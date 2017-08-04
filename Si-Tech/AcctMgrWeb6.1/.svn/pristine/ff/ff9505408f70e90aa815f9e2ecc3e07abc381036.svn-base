package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/6/29.
 */
public class BillDisp3LevelEntity implements Serializable {
    @JSONField(name = "SHOW_NAME")
    @ParamDesc(path = "SHOW_NAME", cons = ConsType.CT001, len = "100", type = "String", desc = "帐目项名称", memo = "")
    private String showName; /*帐目项展示名称*/

    @JSONField(name = "SHOW_CODE")
    @ParamDesc(path = "SHOW_CODE", cons = ConsType.CT001, len = "10", type = "String", desc = "帐目项代码", memo = "")
    private String showCode;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "14", type = "long", desc = "应收费用", memo = "")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "优惠费用", memo = "")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "实收费用", memo = "")
    private long realFee;

    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, len = "14", type = "long", desc = "划拨冲销金额", memo = "")
    private long payedPrepay;

    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, len = "14", type = "long", desc = "缴费冲销金额", memo = "")
    private long payedLater;

    @JSONField(name = "PARENT_ITEM_ID")
    @ParamDesc(path = "PARENT_ITEM_ID", cons = ConsType.CT001, len = "10", type = "String", desc = "父级帐目项代码", memo = "")
    private String parentItemId;

    public BillDisp3LevelEntity add(BillDisp3LevelEntity other) {
        BillDisp3LevelEntity newEnt = new BillDisp3LevelEntity();
        newEnt.setShouldPay(this.getShouldPay() + other.getShouldPay());
        newEnt.setFavourFee(this.getFavourFee() + other.getFavourFee());
        newEnt.setRealFee(this.getRealFee() + other.getRealFee());
        newEnt.setPayedPrepay(this.getPayedPrepay() + other.getPayedPrepay());
        newEnt.setPayedLater(this.getPayedLater() + other.getPayedLater());

        return newEnt;
    }

    public String getShowName() {
        return showName;
    }

    public void setShowName(String showName) {
        this.showName = showName;
    }

    public String getShowCode() {
        return showCode;
    }

    public void setShowCode(String showCode) {
        this.showCode = showCode;
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

    public String getParentItemId() {
        return parentItemId;
    }

    public void setParentItemId(String parentItemId) {
        this.parentItemId = parentItemId;
    }

    @Override
    public String toString() {
        return "BillDisp3LevelEntity{" +
                "showName='" + showName + '\'' +
                ", showCode='" + showCode + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", parentItemId='" + parentItemId + '\'' +
                '}';
    }
}
