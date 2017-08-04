package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/3/10.
 * 集团门展示集团帐单实体
 */
public class GrpBillKfEntity implements Serializable {
    @JSONField(name = "PRC_ID")
    @ParamDesc(path = "PRC_ID", cons = ConsType.CT001, type = "String", len = "10", desc = "集团产品定价", memo = "")
    private String prcId;
    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", cons = ConsType.CT001, type = "String", len = "64", desc = "集团产品定价名称", memo = "")
    private String prcName;
    @JSONField(name = "CUST_NAME")
    @ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "String", len = "64", desc = "集团客户名称", memo = "略")
    private String custName;
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "集团帐户号码", memo = "")
    private long contractNo;
    @JSONField(name = "ID_NO")
    @ParamDesc(path = "ID_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "集团用户ID", memo = "略")
    private long idNo;
    @JSONField(name = "CUST_ID")
    @ParamDesc(path = "CUST_ID", cons = ConsType.CT001, type = "long", len = "18", desc = "集团客户ID", memo = "略")
    private long custId;
    @JSONField(name = "PHONE_NO")
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "string", len = "40", desc = "集团手机号码", memo = "略")
    private String phoneNo;
    @JSONField(name = "BILL_REGIN")
    @ParamDesc(path = "BILL_REGIN", cons = ConsType.CT001, type = "int", len = "8", desc = "帐期开始日", memo = "略")
    private int billBegin;
    @JSONField(name = "BILL_END")
    @ParamDesc(path = "BILL_END", cons = ConsType.CT001, type = "int", len = "8", desc = "帐期结束日", memo = "略")
    private int billEnd;
    @JSONField(name = "BILL_CYCLE")
    @ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "6", desc = "帐期", memo = "略")
    private int billCycle;
    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "集团应收总额", memo = "单位：分")
    private long shouldPay;
    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "集团产品优惠金额", memo = "单位：分")
    private long favourFee;
    @JSONField(name = "PREPAY_FEE")
    @ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "集团预存款", memo = "位：分")
    private long prepayFee;
    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "集团欠费金额", memo = "位：分")
    private long oweFee;

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public long getIdNo() {
        return idNo;
    }

    public void setIdNo(long idNo) {
        this.idNo = idNo;
    }

    public long getCustId() {
        return custId;
    }

    public void setCustId(long custId) {
        this.custId = custId;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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

    public int getBillCycle() {
        return billCycle;
    }

    public void setBillCycle(int billCycle) {
        this.billCycle = billCycle;
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

    public long getPrepayFee() {
        return prepayFee;
    }

    public void setPrepayFee(long prepayFee) {
        this.prepayFee = prepayFee;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    @Override
    public String toString() {
        return "GrpBillKfEntity{" +
                "prcId='" + prcId + '\'' +
                ", prcName='" + prcName + '\'' +
                ", custName='" + custName + '\'' +
                ", contractNo=" + contractNo +
                ", idNo=" + idNo +
                ", custId=" + custId +
                ", phoneNo='" + phoneNo + '\'' +
                ", billBegin=" + billBegin +
                ", billEnd=" + billEnd +
                ", billCycle=" + billCycle +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", prepayFee=" + prepayFee +
                ", oweFee=" + oweFee +
                '}';
    }
}
