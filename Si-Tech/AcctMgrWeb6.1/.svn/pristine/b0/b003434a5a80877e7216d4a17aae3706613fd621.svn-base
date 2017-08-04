package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title: 发票信息实体类  </p>
 * <p>Description:  存储发票的所有相关信息 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author fanck
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
public class InvoiceEntity implements Serializable {

	/* 发票张数 */
	@JSONField(name = "INV_NUM")
	@ParamDesc(path = "INV_NUM", cons = ConsType.QUES, type = "int", len = "3", desc = "发票数目", memo = "略")
	private int iInvNum = 0;

	// the code of city 地市编码
	@JSONField(name = "REGION_ID")
	@ParamDesc(path = "REGION_ID", cons = ConsType.QUES, type = "String", len = "20", desc = "地市编码", memo = "略")
	private String regionId;

	@JSONField(name = "BEGIN_NO")
	@ParamDesc(path = "BEGIN_NO", cons = ConsType.QUES, type = "String", len = "40", desc = "开始发票号", memo = "略")
	/* 发票号开始号码 */
	private String sBeginNo = "";

	/* 发票号结束号码 */
	@JSONField(name = "END_NO")
	@ParamDesc(path = "END_NO", cons = ConsType.QUES, type = "String", len = "40", desc = "结束发票号", memo = "略")
	private String sEndNo = "";

	/* 发票上显示电话号 */
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "电话号", memo = "略")
	private String sPhoneNo = "";

	/* 发票上显示的客户姓名 */
	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "客户名称", memo = "略")
	private String sCustName = "";

	/* 客户编码 */
	@JSONField(name = "CUST_ID")
	@ParamDesc(path = "CUST_ID", cons = ConsType.QUES, type = "long", len = "20", desc = "客户ID", memo = "略")
	private long lCustId = 0;

	/* 用户编码 */
	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "用户ID", memo = "略")
	private long lIdNo = 0;

	/* 发票上显示的账户 */
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号", memo = "略")
	private long lContractNo = 0; // 综合表中的账户号

	/* 发票代码 */
	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "40", desc = "发票代码", memo = "略")
	private String sInvCode = "";

	/* 发票模板类型 */
	@JSONField(name = "PRINT_TYPE")
	@ParamDesc(path = "PRINT_TYPE", cons = ConsType.QUES, type = "String", len = "2", desc = "打印类型", memo = "略")
	private String sPrintType = "";

	/* 发票打印工号 */
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "打印工号", memo = "略")
	private String sLoginNo = "";

	/* 组织编码 */
	@JSONField(name = "GROUP_ID")
	@ParamDesc(path = "GROUP_ID", cons = ConsType.QUES, type = "String", len = "20", desc = "组织编码", memo = "略")
	private String sGroupId = "";

	/* 发票打印模块 */
	@JSONField(name = "OPERATION_CODE")
	@ParamDesc(path = "OPERATION_CODE", cons = ConsType.QUES, type = "String", len = "6", desc = "操作代码", memo = "略")
	private String sOpCode = "";

	/* 缴费发票，缴费流水 */
	@JSONField(name = "PAY_SN")
	@ParamDesc(path = "PAY_SN", cons = ConsType.QUES, type = "Long", len = "20", desc = "缴费流水", memo = "略")
	private long lPaySn = 0;

	/* 缴费时间 */
	@JSONField(name = "PAY_TIME")
	@ParamDesc(path = "PAY_TIME", cons = ConsType.QUES, type = "String", len = "30", desc = "缴费时间", memo = "略")
	private String sPayTime;

	/* 缴费金额 */
	@JSONField(name = "PAY_FEE")
	@ParamDesc(path = "PAY_FEE", cons = ConsType.QUES, type = "Long", len = "15", desc = "缴费金额", memo = "略")
	private long lPayFee = 0;

	/* 发票数据list */
	@JSONField(name = "INV_FEE_LIST")
	@ParamDesc(path = "INV_FEE_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票数据列表", memo = "略")
	private List<InvoMutiMonEntity> invFeeList;

	/* 发票打印日期 */
	@JSONField(name = "PRINT_DATE")
	@ParamDesc(path = "PRINT_DATE", cons = ConsType.QUES, type = "String", len = "15", desc = "打印日期", memo = "略")
	private String sPrintDate;

	/* 发票号码列表 */
	@JSONField(name = "INVNO_APPLIED")
	@ParamDesc(path = "INVNO_APPLIED", cons = ConsType.PLUS, type = "compx", len = "1", desc = "申请的发票号", memo = "略")
	private List<InvNoOccupyEntity> invNoList;

	@JSONField(name = "INVNO")
	@ParamDesc(path = "INVNO", cons = ConsType.PLUS, type = "compx", len = "1", desc = "申请的发票号", memo = "略")
	private InvNoOccupyEntity invNoOccupy;

	/* 品牌名称 */
	@JSONField(name = "BRAND_NAME")
	@ParamDesc(path = "BRAND_NAME", cons = ConsType.QUES, type = "String", len = "50", desc = "品牌名称", memo = "略")
	private String brandName;

	@JSONField(name = "PROC_NAME")
	@ParamDesc(path = "PROC_NAME", cons = ConsType.QUES, type = "String", len = "50", desc = "主资费名称", memo = "略")
	private String procName = "";

	/** 缴费方式 **/
	@JSONField(name = "PAY_METHOD")
	@ParamDesc(path = "PAY_METHOD", cons = ConsType.QUES, type = "String", len = "50", desc = "缴费方式", memo = "略")
	private String payMethod;

	@JSONField(name = "REMARK_FLAG")
	@ParamDesc(path = "REMARK_FLAG", cons = ConsType.QUES, type = "Boolean", len = "20", desc = "备注标示", memo = "略")
	private boolean remarkFlag = true;

	@JSONField(name = "DATE_PRESENT_FLAG")
	@ParamDesc(path = "DATE_PRESENT_FLAG", cons = ConsType.QUES, type = "int", len = "10", desc = "日期显示标示", memo = "略")
	private int billCycleDisFlag;

	@JSONField(name = "ITEM_NAME")
	@ParamDesc(path = "ITEM_NAME", cons = ConsType.QUES, type = "String", len = "50", desc = "项目名称", memo = "略")
	private String itemName;

	@JSONField(name = "PRINT_TYPE_ONE")
	@ParamDesc(path = "PRINT_TYPE_ONE", cons = ConsType.QUES, type = "String", len = "5", desc = "打印方式选项1", memo = "略")
	private String printTypeOne;

	@JSONField(name = "PRINT_TYPE_TWO")
	@ParamDesc(path = "PRINT_TYPE_TWO", cons = ConsType.QUES, type = "String", len = "5", desc = "打印方式选项2", memo = "略")
	private String printTypeTwo;

	@JSONField(name = "INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.QUES, type = "String", len = "10", desc = "模板类型", memo = "略")
	private String invType;

	@JSONField(name = "PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.QUES, type = "Long", len = "20", desc = "发票流水号", memo = "略")
	private long printSn;

	@JSONField(name = "BEFORE_PAY")
	@ParamDesc(path = "BEFORE_PAY", cons = ConsType.QUES, type = "String", len = "10", desc = "先开后交费标识", memo = "1：先开票")
	private String beforePay;

	// private int printFlag; //打印标示，0：打印，1：不打印
	@JSONField(name = "PRESENT_ACCT")
	@ParamDesc(path = "PRESENT_ACCT", cons = ConsType.QUES, type = "Long", len = "20", desc = "明细表中账户号，也就是展现出的账户号", memo = "略")
	private long detAcct; // 明细表中账户

	@JSONField(name = "ELECTRICAL_INVOICE")
	@ParamDesc(path = "ELECTRICAL_INVOICE", cons = ConsType.QUES, type = "int", len = "2", desc = "电子发票标示", memo = "1：电子发票；0：不是")
	private int elecType; // 电子发票类型 1：走电子发票流程

	@JSONField(name = "STATE")
	@ParamDesc(path = "STATE", cons = ConsType.QUES, type = "String", len = "2", desc = "电子发票标示", memo = "0:电子发票申请，1：正常")
	private String state;

	@JSONField(name = "UNIT_ID")
	@ParamDesc(path = "UNIT_ID", cons = ConsType.QUES, type = "String", len = "14", desc = "集团编码", memo = "略")
	private String unitId;

	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "集团名字", memo = "略")
	private String unitName;

	@JSONField(name = "MANAGE_NAME")
	@ParamDesc(path = "MANAGER_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "客户经理", memo = "略")
	private String managerName;

	@JSONField(name = "REMARK1")
	@ParamDesc(path = "REMARK", cons = ConsType.QUES, type = "String", len = "1024", desc = "备注", memo = "略")
	private String remark;

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMIAN_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "余额", memo = "略")
	protected long remainFee;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "未出账话费", memo = "略")
	protected long unBillFee;

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.QUES, type = "int", len = "10", desc = "账期", memo = "略")
	protected int billCycle;

	// add by liuhl_bj begin
	@JSONField(name = "OP_NAME")
	@ParamDesc(path = "OP_NAME", cons = ConsType.QUES, type = "String", len = "10", desc = "业务类别", memo = "略")
	private String opName;

	@JSONField(name = "COMPACT_NO")
	@ParamDesc(path = "COMPACT_NO", cons = ConsType.QUES, type = "String", len = "10", desc = "合同号", memo = "略")
	private String compactNo;

	@JSONField(name = "CHECK_NO")
	@ParamDesc(path = "CHECK_NO", cons = ConsType.QUES, type = "String", len = "10", desc = "支票号", memo = "略")
	private String checkNo;

	@JSONField(name = "UNIT_CONTRACT_NO")
	@ParamDesc(path = "UNIT_CONTRACT_NO", cons = ConsType.QUES, type = "String", len = "10", desc = "集团统付号码", memo = "略")
	private String unitContractNo;

	@JSONField(name = "LOGIN_NAME")
	@ParamDesc(path = "LOGIN_NAME", cons = ConsType.QUES, type = "String", len = "10", desc = "开票人", memo = "略")
	private String loginName;

	@JSONField(name = "GROUP_NAME")
	@ParamDesc(path = "GROUP_NAME", cons = ConsType.QUES, type = "String", len = "10", desc = "营业厅", memo = "略")
	private String groupName;

	@JSONField(name = "INVO_PRE")
	@ParamDesc(path = "INVO_PRE", cons = ConsType.QUES, type = "comp", len = "10", desc = "预存发票展示内容", memo = "略")
	private PreInvoiceDispEntity invoPre;

	// add by liuhl_bj end

	public int getBillCycle() {
		return billCycle;
	}

	public PreInvoiceDispEntity getInvoPre() {
		return invoPre;
	}

	public void setInvoPre(PreInvoiceDispEntity invoPre) {
		this.invoPre = invoPre;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getUnBillFee() {
		return unBillFee;
	}

	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
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
	 * @return the regionId
	 */
	public String getRegionId() {
		return regionId;
	}

	/**
	 * @param regionId
	 *            the regionId to set
	 */
	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	/**
	 * @return the elecType
	 */
	public int getElecType() {
		return elecType;
	}

	/**
	 * @param elecType
	 *            the elecType to set
	 */
	public void setElecType(int elecType) {
		this.elecType = elecType;
	}

	/**
	 * @return the detAcct
	 */
	public long getDetAcct() {
		return detAcct;
	}

	/**
	 * @param detAcct
	 *            the detAcct to set
	 */
	public void setDetAcct(long detAcct) {
		this.detAcct = detAcct;
	}

	/**
	 * @return the beforePay
	 */
	public String getBeforePay() {
		return beforePay;
	}

	/**
	 * @param beforePay
	 *            the beforePay to set
	 */
	public void setBeforePay(String beforePay) {
		this.beforePay = beforePay;
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
	 * @return the invType
	 */
	public String getInvType() {
		return invType;
	}

	/**
	 * @param invType
	 *            the invType to set
	 */
	public void setInvType(String invType) {
		this.invType = invType;
	}

	/**
	 * @return the printTypeOne
	 */
	public String getPrintTypeOne() {
		return printTypeOne;
	}

	/**
	 * @param printTypeOne
	 *            the printTypeOne to set
	 */
	public void setPrintTypeOne(String printTypeOne) {
		this.printTypeOne = printTypeOne;
	}

	/**
	 * @return the printTypeTwo
	 */
	public String getPrintTypeTwo() {
		return printTypeTwo;
	}

	/**
	 * @param printTypeTwo
	 *            the printTypeTwo to set
	 */
	public void setPrintTypeTwo(String printTypeTwo) {
		this.printTypeTwo = printTypeTwo;
	}

	/**
	 * @return the billCycleDisFlag
	 */
	public int getBillCycleDisFlag() {
		return billCycleDisFlag;
	}

	/**
	 * @param billCycleDisFlag
	 *            the billCycleDisFlag to set
	 */
	public void setBillCycleDisFlag(int billCycleDisFlag) {
		this.billCycleDisFlag = billCycleDisFlag;
	}

	/**
	 * @return the itemName
	 */
	public String getItemName() {
		return itemName;
	}

	/**
	 * @param itemName
	 *            the itemName to set
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	/**
	 * @return the remarkFlag
	 */
	public boolean isRemarkFlag() {
		return remarkFlag;
	}

	/**
	 * @param remarkFlag
	 *            the remarkFlag to set
	 */
	public void setRemarkFlag(boolean remarkFlag) {
		this.remarkFlag = remarkFlag;
	}

	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}

	/**
	 * @param payMethod
	 *            the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	/**
	 * @return the procName
	 */
	public String getProcName() {
		return procName;
	}

	/**
	 * @param procName
	 *            the procName to set
	 */
	public void setProcName(String procName) {
		this.procName = procName;
	}

	/**
	 * @return the brandName
	 */
	public String getBrandName() {
		return brandName;
	}

	/**
	 * @param brandName
	 *            the brandName to set
	 */
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	/**
	 * @return the invNoList
	 */
	public List<InvNoOccupyEntity> getInvNoList() {
		return invNoList;
	}

	/**
	 * @param invNoList
	 *            the invNoList to set
	 */
	public void setInvNoList(List<InvNoOccupyEntity> invNoList) {
		this.invNoList = invNoList;
	}

	public String getsPayTime() {
		return sPayTime;
	}

	public void setsPayTime(String sPayTime) {
		this.sPayTime = sPayTime;
	}

	public String getsPrintDate() {
		return sPrintDate;
	}

	public void setsPrintDate(String sPrintDate) {
		this.sPrintDate = sPrintDate;
	}

	public long getlPayFee() {
		return lPayFee;
	}

	public void setlPayFee(long lPayFee) {
		this.lPayFee = lPayFee;
	}

	public long getlPaySn() {
		return lPaySn;
	}

	public void setlPaySn(long lPaySn) {
		this.lPaySn = lPaySn;
	}

	public int getiInvNum() {
		return iInvNum;
	}

	public void setiInvNum(int iInvNum) {
		this.iInvNum = iInvNum;
	}

	public String getsBeginNo() {
		return sBeginNo;
	}

	public void setsBeginNo(String sBeginNo) {
		this.sBeginNo = sBeginNo;
	}

	public String getsEndNo() {
		return sEndNo;
	}

	public void setsEndNo(String sEndNo) {
		this.sEndNo = sEndNo;
	}

	public String getsPhoneNo() {
		return sPhoneNo;
	}

	public void setsPhoneNo(String sPhoneNo) {
		this.sPhoneNo = sPhoneNo;
	}

	public String getsCustName() {
		return sCustName;
	}

	public void setsCustName(String sCustName) {
		this.sCustName = sCustName;
	}

	public long getlCustId() {
		return lCustId;
	}

	public void setlCustId(long lCustId) {
		this.lCustId = lCustId;
	}

	public long getlIdNo() {
		return lIdNo;
	}

	public void setlIdNo(long lIdNo) {
		this.lIdNo = lIdNo;
	}

	public long getlContractNo() {
		return lContractNo;
	}

	public void setlContractNo(long lContractNo) {
		this.lContractNo = lContractNo;
	}

	public String getsInvCode() {
		return sInvCode;
	}

	public void setsInvCode(String sInvCode) {
		this.sInvCode = sInvCode;
	}

	public String getsPrintType() {
		return sPrintType;
	}

	public void setsPrintType(String sPrintType) {
		this.sPrintType = sPrintType;
	}

	public String getsLoginNo() {
		return sLoginNo;
	}

	public void setsLoginNo(String sLoginNo) {
		this.sLoginNo = sLoginNo;
	}

	public String getsGroupId() {
		return sGroupId;
	}

	public void setsGroupId(String sGroupId) {
		this.sGroupId = sGroupId;
	}

	public String getsOpCode() {
		return sOpCode;
	}

	public void setsOpCode(String sOpCode) {
		this.sOpCode = sOpCode;
	}

	public List<InvoMutiMonEntity> getInvFeeList() {
		return invFeeList;
	}

	public void setInvFeeList(List<InvoMutiMonEntity> invFeeList) {
		this.invFeeList = invFeeList;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getCompactNo() {
		return compactNo;
	}

	public void setCompactNo(String compactNo) {
		this.compactNo = compactNo;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getUnitContractNo() {
		return unitContractNo;
	}

	public void setUnitContractNo(String unitContractNo) {
		this.unitContractNo = unitContractNo;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	@Override
	public String toString() {
		return "InvoiceEntity [iInvNum=" + iInvNum + ", regionId=" + regionId + ", sBeginNo=" + sBeginNo + ", sEndNo=" + sEndNo + ", sPhoneNo="
				+ sPhoneNo + ", sCustName=" + sCustName + ", lCustId=" + lCustId + ", lIdNo=" + lIdNo + ", lContractNo=" + lContractNo
				+ ", sInvCode=" + sInvCode + ", sPrintType=" + sPrintType + ", sLoginNo=" + sLoginNo + ", sGroupId=" + sGroupId + ", sOpCode="
				+ sOpCode + ", lPaySn=" + lPaySn + ", sPayTime=" + sPayTime + ", lPayFee=" + lPayFee + ", invFeeList=" + invFeeList + ", sPrintDate="
				+ sPrintDate + ", invNoList=" + invNoList + ", brandName=" + brandName + ", procName=" + procName + ", payMethod=" + payMethod
				+ ", remarkFlag=" + remarkFlag + ", billCycleDisFlag=" + billCycleDisFlag + ", itemName=" + itemName + ", printTypeOne="
				+ printTypeOne + ", printTypeTwo=" + printTypeTwo + ", invType=" + invType + ", printSn=" + printSn + ", beforePay=" + beforePay
				+ ", detAcct=" + detAcct + ", elecType=" + elecType + ", state=" + state + ", unitId=" + unitId + ", unitName=" + unitName
				+ ", managerName=" + managerName + ", remark=" + remark + ", remainFee=" + remainFee + ", unBillFee=" + unBillFee + ", billCycle="
				+ billCycle + ", opName=" + opName + ", compactNo=" + compactNo + ", checkNo=" + checkNo + ", unitContractNo=" + unitContractNo
				+ ", loginName=" + loginName + ", groupName=" + groupName + ", invoPre=" + invoPre + "]";
	}

}
