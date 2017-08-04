package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class InvoiceInfoEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="PRINT_SN")
	@ParamDesc(path="PRINT_SN",cons=ConsType.CT001,type="long",len="14",desc="发票业务唯一标示",memo="略")
	String printSn;
	
	@JSONField(name="PRINT_ARRAY")
	@ParamDesc(path="PRINT_ARRAY",cons=ConsType.CT001,type="long",len="3",desc="打印序号，默认为‘1’ 多账期的情况自增记录 ",memo="略")
	String printArray;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="40",desc="记录发票号码 ",memo="略")
	String phoneNo;
	
	@JSONField(name="CUST_ID")
	@ParamDesc(path="CUST_ID",cons=ConsType.CT001,type="long",len="14 ",desc="客户标识 ",memo="略")
	String custId;
	
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="14 ",desc="用户id",memo="略")
	String idNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="14 ",desc="帐户标识  ",memo="略")
	String contractNo;
	
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="long",len="6",desc="月结发票的帐单所属帐期 或者预存发票的缴费帐期",memo="略")
	String billCycle;
	
	@JSONField(name="INV _NO")
	@ParamDesc(path="INV _NO",cons=ConsType.CT001,type="string",len="20",desc="发票号码",memo="略")
	String invNo;
	
	@JSONField(name="INV_CODE")
	@ParamDesc(path="INV_CODE",cons=ConsType.CT001,type="string",len="20",desc="增值税专用发票代码",memo="略")
	String invCode;
	
	@JSONField(name="TCM_CODE")
	@ParamDesc(path="TCM_CODE",cons=ConsType.CT001,type="string",len="20",desc="打印此发票的税控机编码  ",memo="略")
	String tcmCode;
	
	@JSONField(name="INV_REL_NO")
	@ParamDesc(path="INV_REL_NO",cons=ConsType.CT001,type="string",len="20",desc="开具红字发票时,红字发票记录中此字段填写原发票号码；原发票号码打印记录中此字段填写红字发票的发票号码  ",memo="略")
	String invRelNo;
	
	@JSONField(name="STATE")
	@ParamDesc(path="STATE",cons=ConsType.CT001,type="string",len="20",desc="枚举值，不可空0：增值税发票申请1、打印正常发票；2、作废；3、回收；4、全部冲红；5部分冲红；6、打印红字发票;7、重打 ",memo="略")
	String state;
	
	@JSONField(name="STATE_DESC")
	@ParamDesc(path="STATE_DESC",cons=ConsType.CT001,type="long",len="20",desc="状态说明",memo="略")
	String stateDesc;
	
	@JSONField(name="INV_TYPE")
	@ParamDesc(path="INV_TYPE",cons=ConsType.CT001,type="string",len="20",desc="票据模板编码",memo="略")
	String invType;
	
	@JSONField(name="INV_TYPE_DESC")
	@ParamDesc(path="INV_TYPE_DESC",cons=ConsType.CT001,type="string",len="20",desc="票据模板编码",memo="略")
	String invTypeDesc;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="20",desc="打印预存发票对应的缴费流水  ",memo="略")
	String paySn;
	
	@JSONField(name="TOTAL_FEE")
	@ParamDesc(path="TOTAL_FEE",cons=ConsType.CT001,type="long",len="20",desc="含税费在内的总金额 ",memo="略")
	String totalFee;
	
	@JSONField(name="TAX_RATE")
	@ParamDesc(path="TAX_RATE",cons=ConsType.CT001,type="long",len="20",desc="费用所适用的税率  ",memo="略")
	String taxRate;
	
	@JSONField(name="TAX_FEE")
	@ParamDesc(path="TAX_FEE",cons=ConsType.CT001,type="long",len="20",desc="费用税费总额    ",memo="略")
	String taxFee;
	
	@JSONField(name="PRINT_FEE")
	@ParamDesc(path="PRINT_FEE",cons=ConsType.CT001,type="long",len="20",desc="本次发票打印金额",memo="略")
	String printFee;
	
	@JSONField(name="PRINT_NUM")
	@ParamDesc(path="PRINT_NUM",cons=ConsType.CT001,type="long",len="20",desc="打印张数 ",memo="略")
	String printNum;
	
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="string",len="20",desc="打印工号",memo="略")
	String loginNo;
	
	@JSONField(name="GROUP_ID")
	@ParamDesc(path="GROUP_ID",cons=ConsType.CT001,type="string",len="20",desc="组织机构代码",memo="略")
	String groupId;
	
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="string",len="20",desc="发票打印模块操作代码 ",memo="略")
	String opCode;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="long",len="20",desc="打印日期",memo="略")
	String totalDate;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="long",len="20",desc="发票打印的操作时间 ",memo="略")
	String opTime;
	
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="long",len="20",desc="打印发票串信息",memo="略")
	String remark;
	
	@JSONField(name="PRINT_SEQ")
	@ParamDesc(path="PRINT_SEQ",cons=ConsType.CT001,type="long",len="20",desc="打印发票串信息",memo="略")
	String printSeq;
	
	@JSONField(name="END_YMD")
	@ParamDesc(path="END_YMD",cons=ConsType.CT001,type="long",len="20",desc="打印发票串信息",memo="略")
	String endYMD;
	
	@JSONField(name="BEGIN_YMD")
	@ParamDesc(path="BEGIN_YMD",cons=ConsType.CT001,type="long",len="20",desc="打印发票串信息",memo="略")
	String beginYMD;
	
	

	public String getPrintSn() {
		return printSn;
	}

	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}

	public String getPrintArray() {
		return printArray;
	}

	public void setPrintArray(String printArray) {
		this.printArray = printArray;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getInvTypeDesc() {
		return invTypeDesc;
	}

	public void setInvTypeDesc(String invTypeDesc) {
		this.invTypeDesc = invTypeDesc;
	}

	public String getIdNo() {
		return idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(String billCycle) {
		this.billCycle = billCycle;
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

	public String getTcmCode() {
		return tcmCode;
	}

	public void setTcmCode(String tcmCode) {
		this.tcmCode = tcmCode;
	}

	public String getInvRelNo() {
		return invRelNo;
	}

	public void setInvRelNo(String invRelNo) {
		this.invRelNo = invRelNo;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public String getPaySn() {
		return paySn;
	}

	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}

	public String getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}

	public String getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(String taxRate) {
		this.taxRate = taxRate;
	}

	public String getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(String taxFee) {
		this.taxFee = taxFee;
	}

	public String getPrintFee() {
		return printFee;
	}

	public void setPrintFee(String printFee) {
		this.printFee = printFee;
	}

	public String getPrintNum() {
		return printNum;
	}

	public void setPrintNum(String printNum) {
		this.printNum = printNum;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPrintSeq() {
		return printSeq;
	}

	public void setPrintSeq(String printSeq) {
		this.printSeq = printSeq;
	}

	public String getEndYMD() {
		return endYMD;
	}

	public void setEndYMD(String endYMD) {
		this.endYMD = endYMD;
	}

	public String getBeginYMD() {
		return beginYMD;
	}

	public void setBeginYMD(String beginYMD) {
		this.beginYMD = beginYMD;
	}

	public String getStateDesc() {
		return stateDesc;
	}

	public void setStateDesc(String stateDesc) {
		this.stateDesc = stateDesc;
	}
	
}
