package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
/**
 * 
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class TaxInvoEntity implements Serializable {

	@JSONField(name = "RATE_AMOUNT")
	@ParamDesc(path = "RATE_AMOUNT", cons = ConsType.CT001, type = "long", len = "10", desc = "单价费用", memo = "略")
	private long rateAmount;
	/* 发票项名称 */
	@JSONField(name = "FEE_NAME")
	@ParamDesc(path = "FEE_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "增值税发票项名称", memo = "略")
	private String feeName;

	// 总费用
	@JSONField(name = "BILL_FEE")
	@ParamDesc(path = "BILL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "总费用", memo = "略")
	private long totalFee;

	// 单价
	@JSONField(name = "UNIT_FEE")
	@ParamDesc(path = "UNIT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价", memo = "略")
	private long unitFee;

	// 税费
	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费", memo = "略")
	private long taxFee;

	// 税率
	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.CT001, type = "double", len = "10", desc = "税率0", memo = "略")
	private double taxRate;

	// 账务年月
	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "10", desc = "账务年月", memo = "略")
	private int billCycle;

	// 打印标志
	@JSONField(name = "PRINT_FLAG")
	@ParamDesc(path = "PRINT_FLAG", cons = ConsType.CT001, type = "String", len = "3", desc = "发票打印标志", memo = "略")
	private String printFlag;

	// 打印标志指示
	@JSONField(name = "PRINTED_NAME")
	@ParamDesc(path = "PRINTED_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "打印标志指示", memo = "略")
	private String printedName;

	// 打印月份
	@JSONField(name = "PRINT_MONTH")
	@ParamDesc(path = "PRINT_MONTH", cons = ConsType.QUES, type = "int", len = "10", desc = "打印月份", memo = "略")
	private String printedYm;

	// 发票号码
	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	// 发票代码
	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	// 订单号
	@JSONField(name = "ORDER_SN")
	@ParamDesc(path = "ORDER_SN", cons = ConsType.QUES, type = "long", len = "20", desc = "订单号", memo = "略")
	private long orderSn;

	@JSONField(name = "PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.QUES, type = "long", len = "20", desc = "打印流水", memo = "略")
	private long printSn;

	@JSONField(name = "TAXPAYER_ID")
	@ParamDesc(path = "TAXPAYER_ID", cons = ConsType.QUES, type = "String", len = "30", desc = "增值税发票资质号", memo = "略")
	private String taxPayerId;

	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String unitName;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号", memo = "略")
	private String phoneNo;

	@JSONField(name = "LOGIN_NAME")
	@ParamDesc(path = "LOGIN_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "申请工号名称", memo = "略")
	private String loginName;

	@JSONField(name = "REPORT_NAME")
	@ParamDesc(path = "REPORT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "审批工号名称", memo = "略")
	private String reportName;

	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "申请工号", memo = "略")
	private String loginNo;

	@JSONField(name = "REPORT_TO")
	@ParamDesc(path = "REPORT_TO", cons = ConsType.QUES, type = "String", len = "20", desc = "审批工号", memo = "略")
	private String reportTo;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账号", memo = "略")
	private String contractNo;

	@JSONField(name = "STATE")
	@ParamDesc(path = "STATE", cons = ConsType.QUES, type = "String", len = "2", desc = "发票流程状态", memo = "略")
	private String state;

	@JSONField(name = "PRINT_NAME")
	@ParamDesc(path = "PRINT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "发票流程状态名称", memo = "略")
	private String printName;

	@JSONField(name = "REMARK")
	@ParamDesc(path = "REMARK", cons = ConsType.QUES, type = "String", len = "100", desc = "备注", memo = "略")
	private String remark;

	@JSONField(name = "ADDRESS")
	@ParamDesc(path = "ADDRESS", cons = ConsType.QUES, type = "String", len = "100", desc = "公司地址", memo = "略")
	private String adress;

	@JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "开户行", memo = "略")
	private String bankName;

	@JSONField(name = "BANK_ACCOUNT")
	@ParamDesc(path = "BANK_ACCOUNT", cons = ConsType.QUES, type = "long", len = "30", desc = "开户行账号", memo = "略")
	private long bankAccount;

	@JSONField(name = "COM_PHONE")
	@ParamDesc(path = "COM_PHONE", cons = ConsType.QUES, type = "String", len = "20", desc = "公司电号", memo = "略")
	private String comPhoneNo;
	// 折扣折让费用
	@JSONField(name = "FAVRATE_FEE")
	@ParamDesc(path = "FAVRATE_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "折扣折让费用", memo = "略")
	private long favrateFee;

	// 折扣折让费用
	@JSONField(name = "FAVRATE_TAXFEE")
	@ParamDesc(path = "FAVRATE_TAXFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "折扣折让税费", memo = "略")
	private long favrateTaxFee;

	// 折扣折让名称
	@JSONField(name = "FAVNAME")
	@ParamDesc(path = "FAVNAME", cons = ConsType.CT001, type = "string", len = "10", desc = "折扣折让费用", memo = "略")
	private String favName;

	// 开始月份
	@JSONField(name = "BEGIN_YMD")
	@ParamDesc(path = "BEGIN_YMD", cons = ConsType.CT001, type = "int", len = "10", desc = "开始月份", memo = "略")
	private int beginMonth;
	// 结束月份
	@JSONField(name = "END_YMD")
	@ParamDesc(path = "END_YMD", cons = ConsType.CT001, type = "int", len = "10", desc = "结束月份", memo = "略")
	private int endMonth;

	@JSONField(name = "INVC_INITFEE")
	@ParamDesc(path = "INVC_INITFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "冲销表里初始化费用", memo = "略")
	private long invcInitFee;

	// 正常业务费用
	@JSONField(name = "ADDTAX_SHOWNAME")
	@ParamDesc(path = "ADDTAX_SHOWNAME", cons = ConsType.CT001, type = "string", len = "10", desc = "获取或应税劳务名称", memo = "略")
	private String addtaxShowName;

	@JSONField(name = "ADDTAX_SHOWNORDER")
	@ParamDesc(path = "ADDTAX_SHOWNORDER", cons = ConsType.CT001, type = "long", len = "10", desc = "账目顺序", memo = "略")
	private long addtaxShowOrder;
	@JSONField(name = "ADDTAX_PRICE")
	@ParamDesc(path = "ADDTAX_PRICE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价费用", memo = "略")
	private long addtaxPrice;
	@JSONField(name = "ADDTAX_AMOUNT")
	@ParamDesc(path = "ADDTAX_AMOUNT", cons = ConsType.CT001, type = "long", len = "10", desc = "数量", memo = "略")
	private long addtaxAmount;

	@JSONField(name = "ADDTAX_FEE")
	@ParamDesc(path = "ADDTAX_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费金额", memo = "略")
	private long addtaxFee;
	@JSONField(name = "ADDTAX_TOTALFEE")
	@ParamDesc(path = "ADDTAX_TOTALFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long addtaxTotaleFee;

	@JSONField(name = "ADDTAX_FLAG")
	@ParamDesc(path = "ADDTAX_FLAG", cons = ConsType.CT001, type = "long", len = "10", desc = "增值税标示", memo = "略")
	private long addtaxFlag = 0;

	// 折扣业务费用

	@JSONField(name = "DISCODE_SHOWNAME")
	@ParamDesc(path = "DISCODE_SHOWNAME", cons = ConsType.CT001, type = "string", len = "10", desc = "获取或应税劳务名称", memo = "略")
	private String discodeShowName;

	@JSONField(name = "DISCODE_SHOWNORDER")
	@ParamDesc(path = "DISCODE_SHOWNORDER", cons = ConsType.CT001, type = "long", len = "10", desc = "账目顺序", memo = "略")
	private long discodeShowOrder;
	@JSONField(name = "DISCODE_PRICE")
	@ParamDesc(path = "DISCODE_PRICE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价费用", memo = "略")
	private long discodePrice;
	@JSONField(name = "DISCODE_AMOUNT")
	@ParamDesc(path = "DISCODE_AMOUNT", cons = ConsType.CT001, type = "long", len = "10", desc = "数量", memo = "略")
	private long discodeAmount;

	@JSONField(name = "DISCODE_FEE")
	@ParamDesc(path = "DISCODE_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费金额", memo = "略")
	private long discodeFee;
	@JSONField(name = "DISCODE_TOTALFEE")
	@ParamDesc(path = "DISCODE_TOTALFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long discodeTotaleFee;

	@JSONField(name = "DISCODE_FLAG")
	@ParamDesc(path = "DISCODE_FLAG", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long discodeFlag = 0;

	// 为入参使用
	@JSONField(name = "DATA_SOURCE")
	@ParamDesc(path = "DATA_SOURCE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private String dataSource;

	// 为入参使用
	@JSONField(name = "INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private String invType;

	@JSONField(name = "ORDER_INFO")
	@ParamDesc(path = "ORDER_INFO", cons = ConsType.CT001, type = "string", len = "500", desc = "订单集合信息", memo = "略")
	private String orderInfo;

	public String getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getAddtaxShowName() {
		return addtaxShowName;
	}

	public void setAddtaxShowName(String addtaxShowName) {
		this.addtaxShowName = addtaxShowName;
	}

	public long getAddtaxShowOrder() {
		return addtaxShowOrder;
	}

	public void setAddtaxShowOrder(long addtaxShowOrder) {
		this.addtaxShowOrder = addtaxShowOrder;
	}

	public long getAddtaxPrice() {
		return addtaxPrice;
	}

	public void setAddtaxPrice(long addtaxPrice) {
		this.addtaxPrice = addtaxPrice;
	}

	public long getAddtaxAmount() {
		return addtaxAmount;
	}

	public void setAddtaxAmount(long addtaxAmount) {
		this.addtaxAmount = addtaxAmount;
	}

	public long getAddtaxFee() {
		return addtaxFee;
	}

	public void setAddtaxFee(long addtaxFee) {
		this.addtaxFee = addtaxFee;
	}

	public long getAddtaxTotaleFee() {
		return addtaxTotaleFee;
	}

	public void setAddtaxTotaleFee(long addtaxTotaleFee) {
		this.addtaxTotaleFee = addtaxTotaleFee;
	}

	public long getAddtaxFlag() {
		return addtaxFlag;
	}

	public void setAddtaxFlag(long addtaxFlag) {
		this.addtaxFlag = addtaxFlag;
	}

	public String getDiscodeShowName() {
		return discodeShowName;
	}

	public void setDiscodeShowName(String discodeShowName) {
		this.discodeShowName = discodeShowName;
	}

	public long getDiscodeShowOrder() {
		return discodeShowOrder;
	}

	public void setDiscodeShowOrder(long discodeShowOrder) {
		this.discodeShowOrder = discodeShowOrder;
	}

	public long getDiscodePrice() {
		return discodePrice;
	}

	public void setDiscodePrice(long discodePrice) {
		this.discodePrice = discodePrice;
	}

	public long getDiscodeAmount() {
		return discodeAmount;
	}

	public void setDiscodeAmount(long discodeAmount) {
		this.discodeAmount = discodeAmount;
	}

	public long getDiscodeFee() {
		return discodeFee;
	}

	public void setDiscodeFee(long discodeFee) {
		this.discodeFee = discodeFee;
	}

	public long getDiscodeTotaleFee() {
		return discodeTotaleFee;
	}

	public void setDiscodeTotaleFee(long discodeTotaleFee) {
		this.discodeTotaleFee = discodeTotaleFee;
	}

	public long getDiscodeFlag() {
		return discodeFlag;
	}

	public void setDiscodeFlag(long discodeFlag) {
		this.discodeFlag = discodeFlag;
	}

	/**
	 * @return the adress
	 */
	public String getAdress() {
		return adress;
	}

	/**
	 * @param adress
	 *            the adress to set
	 */
	public void setAdress(String adress) {
		this.adress = adress;
	}

	/**
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName
	 *            the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**
	 * @return the bankAccount
	 */
	public long getBankAccount() {
		return bankAccount;
	}

	/**
	 * @param bankAccount
	 *            the bankAccount to set
	 */
	public void setBankAccount(long bankAccount) {
		this.bankAccount = bankAccount;
	}

	/**
	 * @return the comPhoneNo
	 */
	public String getComPhoneNo() {
		return comPhoneNo;
	}

	/**
	 * @param comPhoneNo
	 *            the comPhoneNo to set
	 */
	public void setComPhoneNo(String comPhoneNo) {
		this.comPhoneNo = comPhoneNo;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the printName
	 */
	public String getPrintName() {
		return printName;
	}

	/**
	 * @param printName
	 *            the printName to set
	 */
	public void setPrintName(String printName) {
		this.printName = printName;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the contractNo
	 */
	public String getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo
	 *            the contractNo to set
	 */
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo
	 *            the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the reportTo
	 */
	public String getReportTo() {
		return reportTo;
	}

	/**
	 * @param reportTo
	 *            the reportTo to set
	 */
	public void setReportTo(String reportTo) {
		this.reportTo = reportTo;
	}

	/**
	 * @return the loginName
	 */
	public String getLoginName() {
		return loginName;
	}

	/**
	 * @param loginName
	 *            the loginName to set
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	/**
	 * @return the reportName
	 */
	public String getReportName() {
		return reportName;
	}

	/**
	 * @param reportName
	 *            the reportName to set
	 */
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the orderSn
	 */
	public long getOrderSn() {
		return orderSn;
	}

	/**
	 * @param orderSn
	 *            the orderSn to set
	 */
	public void setOrderSn(long orderSn) {
		this.orderSn = orderSn;
	}

	/**
	 * @return the printSn
	 */
	public long getPrintSn() {
		return printSn;
	}

	/**
	 * @param printSn
	 *            the printSn to set
	 */
	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	/**
	 * @return the taxPayerId
	 */
	public String getTaxPayerId() {
		return taxPayerId;
	}

	/**
	 * @param taxPayerId
	 *            the taxPayerId to set
	 */
	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	/**
	 * @return the unitName
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * @param unitName
	 *            the unitName to set
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * @return the printedYm
	 */
	public String getPrintedYm() {
		return printedYm;
	}

	/**
	 * @param printedYm
	 *            the printedYm to set
	 */
	public void setPrintedYm(String printedYm) {
		this.printedYm = printedYm;
	}

	/**
	 * @return the invNo
	 */
	public String getInvNo() {
		return invNo;
	}

	/**
	 * @param invNo
	 *            the invNo to set
	 */
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	/**
	 * @return the invCode
	 */
	public String getInvCode() {
		return invCode;
	}

	/**
	 * @param invCode
	 *            the invCode to set
	 */
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	/**
	 * 
	 */
	public TaxInvoEntity() {
		// TODO Auto-generated constructor stub
	}

	public TaxInvoEntity(Map<String, Object> in) {
		this.feeName = MapUtils.getString(in, "FEE_NAME", "");
		this.totalFee = MapUtils.getLongValue(in, "BILL_FEE");
		this.unitFee = MapUtils.getLongValue(in, "UNIT_FEE");
		this.taxFee = MapUtils.getLongValue(in, "TAX_FEE");
		this.taxRate = MapUtils.getDoubleValue(in, "TAX_RATE");
		this.billCycle = MapUtils.getIntValue(in, "BILL_CYCLE");
		this.printFlag = MapUtils.getString(in, "PRINT_FLAG", "0");
		this.printedName = MapUtils.getString(in, "PRINTED_NAME", "未打印");

	}

	public MBean encode(MBean in) {

		return in;
	}

	public String getFeeName() {
		return feeName;
	}

	public void setFeeName(String feeName) {
		this.feeName = feeName;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public long getUnitFee() {
		return unitFee;
	}

	public void setUnitFee(long unitFee) {
		this.unitFee = unitFee;
	}

	public long getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(long taxFee) {
		this.taxFee = taxFee;
	}

	public double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getPrintFlag() {
		return printFlag;
	}

	public void setPrintFlag(String printFlag) {
		this.printFlag = printFlag;
	}

	public String getPrintedName() {
		return printedName;
	}

	public void setPrintedName(String printedName) {
		this.printedName = printedName;
	}

	public long getRateAmount() {
		return rateAmount;
	}

	public void setRateAmount(long rateAmount) {
		this.rateAmount = rateAmount;
	}

	public long getFavrateFee() {
		return favrateFee;
	}

	public void setFavrateFee(long favrateFee) {
		this.favrateFee = favrateFee;
	}

	public String getFavName() {
		return favName;
	}

	public void setFavName(String favName) {
		this.favName = favName;
	}

	public int getBeginMonth() {
		return beginMonth;
	}

	public void setBeginMonth(int beginMonth) {
		this.beginMonth = beginMonth;
	}

	public int getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(int endMonth) {
		this.endMonth = endMonth;
	}

	public long getFavrateTaxFee() {
		return favrateTaxFee;
	}

	public void setFavrateTaxFee(long favrateTaxFee) {
		this.favrateTaxFee = favrateTaxFee;
	}

	public long getInvcInitFee() {
		return invcInitFee;
	}

	public void setInvcInitFee(long invcInitFee) {
		this.invcInitFee = invcInitFee;
	}

	@Override
	public String toString() {
		return "TaxInvoEntity [rateAmount=" + rateAmount + ", feeName=" + feeName + ", totalFee=" + totalFee + ", unitFee=" + unitFee + ", taxFee="
				+ taxFee + ", taxRate=" + taxRate + ", billCycle=" + billCycle + ", printFlag=" + printFlag + ", printedName=" + printedName
				+ ", printedYm=" + printedYm + ", invNo=" + invNo + ", invCode=" + invCode + ", orderSn=" + orderSn + ", printSn=" + printSn
				+ ", taxPayerId=" + taxPayerId + ", unitName=" + unitName + ", phoneNo=" + phoneNo + ", loginName=" + loginName + ", reportName="
				+ reportName + ", loginNo=" + loginNo + ", reportTo=" + reportTo + ", contractNo=" + contractNo + ", state=" + state + ", printName="
				+ printName + ", remark=" + remark + ", adress=" + adress + ", bankName=" + bankName + ", bankAccount=" + bankAccount
				+ ", comPhoneNo=" + comPhoneNo + ", favrateFee=" + favrateFee + ", favrateTaxFee=" + favrateTaxFee + ", favName=" + favName
				+ ", beginMonth=" + beginMonth + ", endMonth=" + endMonth + ", invcInitFee=" + invcInitFee + ", addtaxShowName=" + addtaxShowName
				+ ", addtaxShowOrder=" + addtaxShowOrder + ", addtaxPrice=" + addtaxPrice + ", addtaxAmount=" + addtaxAmount + ", addtaxFee="
				+ addtaxFee + ", addtaxTotaleFee=" + addtaxTotaleFee + ", addtaxFlag=" + addtaxFlag + ", discodeShowName=" + discodeShowName
				+ ", discodeShowOrder=" + discodeShowOrder + ", discodePrice=" + discodePrice + ", discodeAmount=" + discodeAmount + ", discodeFee="
				+ discodeFee + ", discodeTotaleFee=" + discodeTotaleFee + ", discodeFlag=" + discodeFlag + ", dataSource=" + dataSource
				+ ", invType=" + invType + ", orderInfo=" + orderInfo + "]";
	}

	public boolean compareTo(TaxInvoEntity other) {

		return true;
	}

}
