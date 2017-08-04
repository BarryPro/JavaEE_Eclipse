package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.math.BigDecimal;

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
 * @author wangxind
 * @version 1.0
 */
@SuppressWarnings("serial")
public class TaxInvoTotalEntity implements Serializable {

	@JSONField(name = "AUDIT_SN")
	@ParamDesc(path = "AUDIT_SN", cons = ConsType.CT001, type = "string", len = "10", desc = "关联流水", memo = "略")
	private String auditSn;
	@JSONField(name = "PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.CT001, type = "long", len = "10", desc = "打印流水", memo = "略")
	private long printSn;
	@JSONField(name = "ORDER_SN")
	@ParamDesc(path = "ORDER_SN", cons = ConsType.CT001, type = "long", len = "10", desc = "流水", memo = "略")
	private long orderSn;

	@JSONField(name = "TOTAL_FEE")
	@ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "增值税金额", memo = "略")
	private long totalFee;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "double", len = "10", desc = "发票金额", memo = "略")
	private double printFee;

	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税额", memo = "略")
	private long taxFee;

	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.CT001, type = "double", len = "10", desc = "税率", memo = "略")
	private double tax_rate;
	

	@JSONField(name = "STATE")
	@ParamDesc(path = "STATE", cons = ConsType.CT001, type = "string", len = "10", desc = "审批单状态名字", memo = "略")
	private String state;

	@JSONField(name = "STATE_TYPE")
	@ParamDesc(path = "STATE_TYPE", cons = ConsType.QUES, type = "string", len = "2", desc = "审批单状态", memo = "略")
	private String stateType;
	
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "10", desc = "账号", memo = "略")
	private long contractNo;

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "long", len = "10", desc = "账期月份", memo = "略")
	private long billCycle;

	@JSONField(name = "YEAR_MONTH")
	@ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, type = "long", len = "10", desc = "生成数据月份", memo = "略")
	private long yearMonth;

	@JSONField(name = "REMARK")
	@ParamDesc(path = "REMARK", cons = ConsType.CT001, type = "String", len = "10", desc = "发票备注", memo = "略")
	private String remark;
	
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "手机号", memo = "略")
	private String phoneNo;
	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "发票号码", memo = "略")
	private String invNo;
	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.CT001, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;
	
	@JSONField(name = "INV_CNT")
	@ParamDesc(path = "INV_CNT", cons = ConsType.CT001, type = "String", len = "20", desc = "发票总数", memo = "略")	
	private int invcnt;
     
	//------------------------纳税人基本信息 start --------------------------------------//
	
	@JSONField(name = "ADDRESS")
	@ParamDesc(path = "ADDRESS", cons = ConsType.QUES, type = "String", len = "100", desc = "纳税人公司地址", memo = "略")
	private String adress;

	@JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "纳税人开户行", memo = "略")
	private String bankName;

	@JSONField(name = "BANK_ACCOUNT")
	@ParamDesc(path = "BANK_ACCOUNT", cons = ConsType.QUES, type = "string", len = "30", desc = "纳税人开户行账号", memo = "略")
	private String bankAccount;

	@JSONField(name = "COM_PHONE")
	@ParamDesc(path = "COM_PHONE", cons = ConsType.QUES, type = "String", len = "20", desc = "纳税人公司电号", memo = "略")
	private String comPhoneNo;
	
	
	@JSONField(name = "TAXPAYER_ID")
	@ParamDesc(path = "TAXPAYER_ID", cons = ConsType.QUES, type = "String", len = "30", desc = "增值税发票资质号", memo = "略")
	private String taxPayerId;

	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String unitName;
	
	@JSONField(name = "PRINT_SEQ")
	@ParamDesc(path = "PRINT_SEQ", cons = ConsType.QUES, type = "int", len = "2", desc = "发票序号", memo = "略")
	private int printSeq;
	
	//------------------------纳税人基本信息 end --------------------------------------//
	//********************************************************增值税业务费用**************************************************//
    //正常业务费用
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
	@ParamDesc(path = "ADDTAX_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价金额", memo = "略")
	private long addtaxFee;
	
	@JSONField(name = "ADDTAX_TAXFEE")
	@ParamDesc(path = "ADDTAX_TAXFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费金额", memo = "略")
	private long addtaxTaxFee;
	
	@JSONField(name = "ADDTAX_TOTALFEE")
	@ParamDesc(path = "ADDTAX_TOTALFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long addtaxTotaleFee;

	@JSONField(name = "ADDTAX_FLAG")
	@ParamDesc(path = "ADDTAX_FLAG", cons = ConsType.CT001, type = "long", len = "10", desc = "标志", memo = "略")
	private long addtaxFlag = 0;
	
	//********************************************************折扣业务费用**************************************************//
	
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
	@ParamDesc(path = "DISCODE_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价金额", memo = "略")
	private long discodeFee;
	
	
	@JSONField(name = "DISCODE_TAXFEE")
	@ParamDesc(path = "DISCODE_TAXFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费金额", memo = "略")
	private long discodeTaxFee;
	
	
	@JSONField(name = "DISCODE_TOTALFEE")
	@ParamDesc(path = "DISCODE_TOTALFEE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long discodeTotaleFee;
	
	@JSONField(name = "DISCODE_FLAG")
	@ParamDesc(path = "DISCODE_FLAG", cons = ConsType.CT001, type = "long", len = "10", desc = "标志", memo = "略")
	private long discodeFlag = 0;
	
	//-----------------------------------
	@JSONField(name = "BEGIN_YMD")
	@ParamDesc(path = "BEGIN_YMD", cons = ConsType.QUES, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String beginYmd;
	
	@JSONField(name = "END_YMD")
	@ParamDesc(path = "END_YMD", cons = ConsType.QUES, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String endYmd;
	
	
	/**查询总金额模块入参**/
	@JSONField(name = "FLOW_ID")
	@ParamDesc(path = "FLOW_ID", cons = ConsType.QUES, type = "long", len = "100", desc = "模块信息", memo = "略")
	private long flowId;
	@JSONField(name = "SIXTAX_CNT")
	@ParamDesc(path = "SIXTAX_CNT", cons = ConsType.QUES, type = "long", len = "100", desc = "6%税务发票", memo = "略")
	private int taxrate6Cnt; 
	@JSONField(name = "ELSIXTAX_CNT")
	@ParamDesc(path = "ELSIXTAX_CNT", cons = ConsType.QUES, type = "long", len = "100", desc = "11%税务发票", memo = "略")
	private int taxrate11Cnt;
	@JSONField(name = "SEVELSIXTAX_CNT")
	@ParamDesc(path = "SEVELSIXTAX_CNT", cons = ConsType.QUES, type = "long", len = "100", desc ="17%税务发票", memo = "略")
	private int taxrate17Cnt;
	
	@JSONField(name = "INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.QUES, type = "String", len = "2", desc = "发票类型", memo = "略")
	private String invType;
	
	//***红票相关信息,红票出参需要操作**//
	@JSONField(name = "REDINV_CAUSE")
	@ParamDesc(path = "REDINV_CAUSE", cons = ConsType.QUES, type = "String", len = "2", desc = "红字发票原因", memo = "略")
	private String redinvCause;
	
	@JSONField(name = "REDINV_ORDERNO")
	@ParamDesc(path = "REDINV_ORDERNO", cons = ConsType.QUES, type = "String", len = "200", desc = "红字发票通知单号", memo = "略")
	private String redinvOrderNO;
	
	@JSONField(name = "REDINV_REMARK")
	@ParamDesc(path = "REDINV_REMARK", cons = ConsType.QUES, type = "String", len = "200", desc = "红字发票申请原因", memo = "略")
	private String redinvRemark;
	
	
	@JSONField(name = "REDINV_CRMREMARK")
	@ParamDesc(path = "REDINV_CRMREMARK", cons = ConsType.QUES, type = "String", len = "200", desc = "红字发票申请原因", memo = "略")
	private String redinvCrmRemark;
	
	
	
	/**
	 * @return the stateType
	 */
	public String getStateType() {
		return stateType;
	}

	/**
	 * @param stateType the stateType to set
	 */
	public void setStateType(String stateType) {
		this.stateType = stateType;
	}

	public String getRedinvCrmRemark() {
		return redinvCrmRemark;
	}

	public void setRedinvCrmRemark(String redinvCrmRemark) {
		this.redinvCrmRemark = redinvCrmRemark;
	}

	public String getRedinvCause() {
		return redinvCause;
	}

	public void setRedinvCause(String redinvCause) {
		this.redinvCause = redinvCause;
	}

	public String getRedinvOrderNO() {
		return redinvOrderNO;
	}

	public void setRedinvOrderNO(String redinvOrderNO) {
		this.redinvOrderNO = redinvOrderNO;
	}

	public String getRedinvRemark() {
		return redinvRemark;
	}

	public void setRedinvRemark(String redinvRemark) {
		this.redinvRemark = redinvRemark;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public long getFlowId() {
		return flowId;
	}

	public void setFlowId(long flowId) {
		this.flowId = flowId;
	}

	public int getTaxrate6Cnt() {
		return taxrate6Cnt;
	}

	public void setTaxrate6Cnt(int taxrate6Cnt) {
		this.taxrate6Cnt = taxrate6Cnt;
	}

	public int getTaxrate11Cnt() {
		return taxrate11Cnt;
	}

	public void setTaxrate11Cnt(int taxrate11Cnt) {
		this.taxrate11Cnt = taxrate11Cnt;
	}

	public int getTaxrate17Cnt() {
		return taxrate17Cnt;
	}

	public void setTaxrate17Cnt(int taxrate17Cnt) {
		this.taxrate17Cnt = taxrate17Cnt;
	}

	public long getAddtaxTaxFee() {
		return addtaxTaxFee;
	}

	public void setAddtaxTaxFee(long addtaxTaxFee) {
		
		this.addtaxTaxFee = new BigDecimal(addtaxTaxFee / 100.00).setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
	}

	public long getDiscodeTaxFee() {
		return discodeTaxFee;
	}

	public void setDiscodeTaxFee(long discodeTaxFee) {
		this.discodeTaxFee = new BigDecimal(discodeTaxFee / 100.00).setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
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

	public String getAdress() {
		return adress;
	}

	public int getPrintSeq() {
		return printSeq;
	}

	public void setPrintSeq(int printSeq) {
		this.printSeq = printSeq;
	}

	public void setAdress(String adress) {
		this.adress = adress;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	
	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getComPhoneNo() {
		return comPhoneNo;
	}

	public void setComPhoneNo(String comPhoneNo) {
		this.comPhoneNo = comPhoneNo;
	}

	public String getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(String auditSn) {
		this.auditSn = auditSn;
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public long getOrderSn() {
		return orderSn;
	}

	public void setOrderSn(long orderSn) {
		this.orderSn = orderSn;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public double getPrintFee() {
		return printFee;
	}

	public void setPrintFee(double printFee) {
		this.printFee = printFee;
	}

	public long getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(long taxFee) {
		
		this.taxFee = new BigDecimal(taxFee / 100).setScale(0, BigDecimal.ROUND_HALF_UP).longValue(); 
	}

	public double getTax_rate() {
		return tax_rate;
	}

	public void setTax_rate(double tax_rate) {
		this.tax_rate = tax_rate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(long billCycle) {
		this.billCycle = billCycle;
	}

	public long getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(long yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public int getInvcnt() {
		return invcnt;
	}

	public void setInvcnt(int invcnt) {
		this.invcnt = invcnt;
	}
	

	public String getBeginYmd() {
		return beginYmd;
	}

	public void setBeginYmd(String beginYmd) {
		this.beginYmd = beginYmd;
	}

	public String getEndYmd() {
		return endYmd;
	}

	public void setEndYmd(String endYmd) {
		this.endYmd = endYmd;
	}

	public boolean compareTo(TaxInvoTotalEntity other) {

		return true;
	}

}
