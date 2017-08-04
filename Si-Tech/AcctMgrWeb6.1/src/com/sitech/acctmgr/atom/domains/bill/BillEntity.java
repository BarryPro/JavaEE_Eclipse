package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class BillEntity implements Serializable {

    @JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, type = "long", len = "6", desc = "用户ID", memo = "略")
    private long idNo;

    @JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "6", desc = "账户ID", memo = "略")
    private long contractNo;

    @JSONField(name = "SHOULD_PAY")
	@ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "6", desc = "应收金额", memo = "略")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
	@ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "6", desc = "优惠金额", memo = "略")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
	@ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "6", desc = "应收-优惠", memo = "略")
    private long realFee;

    @JSONField(name = "PAYED_PREPAY")
	@ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "6", desc = "预存划拨", memo = "略")
    private long payedPrepay;

    @JSONField(name = "PAYED_LATER")
	@ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "6", desc = "划拨金额", memo = "略")
    private long payedLater;

    @JSONField(name = "NATURAL_MONTH")
	@ParamDesc(path = "NATURAL_MONTH", cons = ConsType.CT001, type = "int", len = "6", desc = "自然月", memo = "略")
    private int naturalMonth;

    @JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "6", desc = "账期年月", memo = "略")
    private int billCycle;

    @JSONField(name = "BILL_BEGIN")
	@ParamDesc(path = "BILL_BEGIN", cons = ConsType.CT001, type = "int", len = "6", desc = "账期开始时间", memo = "略")
    private int billBegin;

    @JSONField(name = "BILL_END")
	@ParamDesc(path = "BILL_END", cons = ConsType.CT001, type = "int", len = "6", desc = "账期结束时间", memo = "略")
    private int billEnd;

    @JSONField(name = "BILL_TYPE")
	@ParamDesc(path = "BILL_TYPE", cons = ConsType.CT001, type = "String", len = "6", desc = "账期类型", memo = "略")
    private String billType;

    @JSONField(name = "BILL_DAY")
	@ParamDesc(path = "BILL_DAY", cons = ConsType.CT001, type = "int", len = "6", desc = "账期日期", memo = "略")
    private int billDay;

    @JSONField(name = "ACCT_ITEM_CODE")
	@ParamDesc(path = "ACCT_ITEM_CODE", cons = ConsType.CT001, type = "int", len = "6", desc = "账目项", memo = "略")
    private String acctItemCode;

    private String parentItemId;

    @JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.CT001, type = "double", len = "6", desc = "税率", memo = "略")
    private double taxRate;

    @JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.CT001, type = "long", len = "6", desc = "税费", memo = "略")
    private long taxFee;

    @JSONField(name = "PAYED_TAX")
	@ParamDesc(path = "PAYED_TAX", cons = ConsType.CT001, type = "long", len = "6", desc = "已缴税费", memo = "略")
    private long payedTax;

    @JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "6", desc = "欠费金额", memo = "略")
	// 账单欠费金额
    private long oweFee;

    @JSONField(name = "CYCLE_TYPE")
	@ParamDesc(path = "CYCLE_TYPE", cons = ConsType.CT001, type = "string", len = "6", desc = "", memo = "略")
    private String cycleType;

    @JSONField(name = "ITEM_NAME")
	@ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, type = "string", len = "6", desc = "账目项名称", memo = "略")
	// 账目项名称
    private String itemName;

    @JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "string", len = "6", desc = "服务号码", memo = "略")
    private String phoneNo;

    @JSONField(name = "PROD_PRCID")
	@ParamDesc(path = "PROD_PRCID", cons = ConsType.CT001, type = "int", len = "6", desc = "资费", memo = "略")
    private String prodPrcId;

    @JSONField(name = "CUST_PAY")
	@ParamDesc(path = "CUST_PAY", cons = ConsType.CT001, type = "int", len = "6", desc = "客户支付", memo = "略")
    private long custPay;

    @JSONField(name = "MOBILE_PAY")
	@ParamDesc(path = "MOBILE_PAY", cons = ConsType.CT001, type = "int", len = "6", desc = "移动支付", memo = "略")
    private long mobilePay;

    public String getItemName() {
        return itemName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    public String getCycleType() {
        return cycleType;
    }

    public void setCycleType(String cycleType) {
        this.cycleType = cycleType;
    }

    public long getIdNo() {
        return idNo;
    }

    public void setIdNo(long idNo) {
        this.idNo = idNo;
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

    public int getNaturalMonth() {
        return naturalMonth;
    }

    public void setNaturalMonth(int naturalMonth) {
        this.naturalMonth = naturalMonth;
    }

    public int getBillCycle() {
        return billCycle;
    }

    public void setBillCycle(int billCycle) {
        this.billCycle = billCycle;
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

    public int getBillDay() {
        return billDay;
    }

    public void setBillDay(int billDay) {
        this.billDay = billDay;
    }

    public String getAcctItemCode() {
        return acctItemCode;
    }

    public void setAcctItemCode(String acctItemCode) {
        this.acctItemCode = acctItemCode;
    }

    public String getParentItemId() {
        return parentItemId;
    }

    public void setParentItemId(String parentItemId) {
        this.parentItemId = parentItemId;
    }

    public double getTaxRate() {
        return taxRate;
    }

    public void setTaxRate(double taxRate) {
        this.taxRate = taxRate;
    }

    public long getTaxFee() {
        return taxFee;
    }

    public void setTaxFee(long taxFee) {
        this.taxFee = taxFee;
    }

    public long getPayedTax() {
        return payedTax;
    }

    public void setPayedTax(long payedTax) {
        this.payedTax = payedTax;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public String getBillType() {
        return billType;
    }

    public void setBillType(String billType) {
        this.billType = billType;
    }

    public String getProdPrcId() {
        return prodPrcId;
    }

    public void setProdPrcId(String prodPrcId) {
        this.prodPrcId = prodPrcId;
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

    @Override
    public String toString() {
        return "BillEntity{" +
                "idNo=" + idNo +
                ", contractNo=" + contractNo +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", naturalMonth=" + naturalMonth +
                ", billCycle=" + billCycle +
                ", billBegin=" + billBegin +
                ", billEnd=" + billEnd +
                ", billType='" + billType + '\'' +
                ", billDay=" + billDay +
                ", acctItemCode='" + acctItemCode + '\'' +
                ", parentItemId='" + parentItemId + '\'' +
                ", taxRate=" + taxRate +
                ", taxFee=" + taxFee +
                ", payedTax=" + payedTax +
                ", oweFee=" + oweFee +
                ", cycleType='" + cycleType + '\'' +
                ", itemName='" + itemName + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", prodPrcId='" + prodPrcId + '\'' +
                ", custPay=" + custPay +
                ", mobilePay=" + mobilePay +
                '}';
    }
}
