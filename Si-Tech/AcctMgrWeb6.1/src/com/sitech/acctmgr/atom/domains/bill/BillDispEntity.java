package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/6/22.
 * 用途：用于帐单明细展示时，费用级别展示实体
 */
public class BillDispEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@JSONField(name = "ID_NO")
    @ParamDesc(path = "ID_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "用户ID标识", memo = "略")
    private long idNo;

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "用户帐户标识", memo = "略")
    private long contractNo;

    @JSONField(name = "BILL_DAY")
    @ParamDesc(path = "BILL_DAY", cons = ConsType.CT001, type = "int", len = "4", desc = "用户帐户标识", memo = "略")
    private int billDay;

    @JSONField(name = "SHOW_NAME")
    @ParamDesc(path = "SHOW_NAME", cons = ConsType.CT001, type = "String", len = "40", desc = "帐目项展示名称", memo = "略")
    private String showName; /*帐目项展示名称*/

    @JSONField(name = "SHOW_CODE")
    @ParamDesc(path = "SHOW_CODE", cons = ConsType.CT001, type = "String", len = "40", desc = "帐目项代码", memo = "略")
    private String showCode;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "20", desc = "应收", memo = "单位：分")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "优惠", memo = "单位：分")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "实收", memo = "单位：分")
    private long realFee;

    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "20", desc = "划拨冲销金额", memo = "单位：分")
    private long payedPrepay;

    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "20", desc = "缴费冲销金额", memo = "单位：分")
    private long payedLater;

    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "欠费", memo = "单位：分")
    private long oweFee;

    @JSONField(name = "PARENT_ITEM_ID")
    @ParamDesc(path = "PARENT_ITEM_ID", cons = ConsType.CT001, type = "string", len = "10", desc = "父类代码", memo = "略")
    private String parentItemId;

    @JSONField(name = "PARENT_SHOW_NAME")
    @ParamDesc(path = "PARENT_SHOW_NAME", cons = ConsType.CT001, type = "String", len = "40", desc = "上级帐目项展示名称", memo = "略")
    private String parentShowName; /*上级帐目项展示名称*/

    @JSONField(name = "PAYED_STATUS_NAME")
    @ParamDesc(path = "PAYED_STATUS_NAME", cons = ConsType.CT001, type = "string", len = "5", desc = "帐单状态", memo = "略")
    private String payedStatusName;

    public long getIdNo() {
        return idNo;
    }

    public void setIdNo(long idNo) {
        this.idNo = idNo;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public int getBillDay() {
        return billDay;
    }

    public void setBillDay(int billDay) {
        this.billDay = billDay;
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

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    public String getParentItemId() {
        return parentItemId;
    }

    public void setParentItemId(String parentItemId) {
        this.parentItemId = parentItemId;
    }

    public String getParentShowName() {
        return parentShowName;
    }

    public void setParentShowName(String parentShowName) {
        this.parentShowName = parentShowName;
    }

    public String getPayedStatusName() {
        return payedStatusName;
    }

    public void setPayedStatusName(String payedStatusName) {
        this.payedStatusName = payedStatusName;
    }

    @Override
    public String toString() {
        return "BillDispEntity{" +
                "idNo=" + idNo +
                ", contractNo=" + contractNo +
                ", billDay=" + billDay +
                ", showName='" + showName + '\'' +
                ", showCode='" + showCode + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", oweFee=" + oweFee +
                ", parentItemId='" + parentItemId + '\'' +
                ", parentShowName='" + parentShowName + '\'' +
                ", payedStatusName='" + payedStatusName + '\'' +
                '}';
    }
}
