package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class BalanceEntity {
	
	@JSONField(name="BALANCE_ID")
	@ParamDesc(path="BALANCE_ID",cons=ConsType.CT001,type="long",len="20",desc="账本标识",memo="略")
	private long balanceId = 0;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户ID",memo="略")
	private long contractNo = 0;
	
	@JSONField(name="PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="20",desc="账本类型",memo="略")
	private String payType = "";
	
	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="20",desc="账本类型名称",memo="略")
	private String payTypeName = "";
	
	@JSONField(name="SPECIAL_FLAG")
	@ParamDesc(path="SPECIAL_FLAG",cons=ConsType.CT001,type="String",len="2",desc="是否专款标志",memo="略")
	private String specialFlag = "";
	
	@JSONField(name="SPECIAL_FLAG_NAME")
	@ParamDesc(path="SPECIAL_FLAG_NAME",cons=ConsType.CT001,type="String",len="20",desc="是否专款",memo="略")
	private String specialFlagName = "";
	
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="String",len="50",desc="备注",memo="略")
	private String remark = "";
	
	@JSONField(name="BACK_FLAG")
	@ParamDesc(path="BACK_FLAG",cons=ConsType.CT001,type="String",len="2",desc="可退标志",memo="略")
	private String backFlag = "";
	
	@JSONField(name="BACK_FLAG_NAME")
	@ParamDesc(path="BACK_FLAG_NAME",cons=ConsType.CT001,type="String",len="20",desc="是否可退",memo="略")
	private String backFlagName = "";
	
	@JSONField(name="INIT_BALANCE")
	@ParamDesc(path="INIT_BALANCE",cons=ConsType.CT001,type="long",len="20",desc="初始预存",memo="略")
	private long initBalance = 0;
	
	@JSONField(name="CUR_BALANCE")
	@ParamDesc(path="CUR_BALANCE",cons=ConsType.CT001,type="long",len="20",desc="当前预存",memo="略")
	private long curBalance = 0;
	
	@JSONField(name="PRE_BALANCE")
	@ParamDesc(path="PRE_BALANCE",cons=ConsType.CT001,type="long",len="20",desc="出账时预存",memo="略")
	private long preBalance = 0;
	
	@JSONField(name="WRTOFF_MONTH")
	@ParamDesc(path="WRTOFF_MONTH",cons=ConsType.CT001,type="int",len="6",desc="销账年月",memo="略")
	private int wrtoffMonth = 0;
	
	@JSONField(name="BALANCE_TYPE")
	@ParamDesc(path="BALANCE_TYPE",cons=ConsType.CT001,type="String",len="2",desc="入账类型",memo="略")
	private String balanceType = "";
	
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="20",desc="开始时间",memo="略")
	private String beginTime = "";
	
	@JSONField(name="END_TIME")
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="20",desc="结束时间",memo="略")
	private String endTime = "";
	
	@JSONField(name="PAY_TIME")
	@ParamDesc(path="PAY_TIME",cons=ConsType.CT001,type="String",len="20",desc="缴费时间",memo="略")	
	private String payTime = "";
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="30",desc="缴费流水",memo="略")	
	private long paySn = 0;
	
	@JSONField(name="PRINT_FLAG")
	@ParamDesc(path="PRINT_FLAG",cons=ConsType.CT001,type="String",len="2",desc="打印发票标识",memo="略")	
	private String printFlag = "";
	
	@JSONField(name="FOREIGN_SN")
	@ParamDesc(path="FOREIGN_SN",cons=ConsType.CT001,type="String",len="50",desc="外部流水",memo="略")
	private String foreignSn = "";
	
	@JSONField(name="PAY_FLAG")
	@ParamDesc(path="PAY_FLAG",cons=ConsType.CT001,type="int",len="2",desc="账本类型",memo="0:普通账本, 1:赠费账本")
	private String payFlag = "";
	@JSONField(name="PAY_FLAG_NAME")
	@ParamDesc(path="PAY_FLAG_NAME",cons=ConsType.CT001,type="String",len="50",desc="账本类型名称",memo="略")
	private String payFlagName = "";
	
	@JSONField(name="PRIORITY")
	@ParamDesc(path="PRIORITY",cons=ConsType.CT001,type="String",len="20",desc="冲销优先级",memo="账本冲销顺序，从小到大依次冲销")
	private String priority = "";

	public long getBalanceId() {
		return balanceId;
	}

	public void setBalanceId(long balanceId) {
		this.balanceId = balanceId;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public long getInitBalance() {
		return initBalance;
	}

	public void setInitBalance(long initBalance) {
		this.initBalance = initBalance;
	}

	public long getCurBalance() {
		return curBalance;
	}

	public void setCurBalance(long curBalance) {
		this.curBalance = curBalance;
	}

	public long getPreBalance() {
		return preBalance;
	}

	public void setPreBalance(long preBalance) {
		this.preBalance = preBalance;
	}

	public int getWrtoffMonth() {
		return wrtoffMonth;
	}

	public void setWrtoffMonth(int wrtoffMonth) {
		this.wrtoffMonth = wrtoffMonth;
	}

	public String getBalanceType() {
		return balanceType;
	}

	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getPayTime() {
		return payTime;
	}

	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public String getPrintFlag() {
		return printFlag;
	}

	public void setPrintFlag(String printFlag) {
		this.printFlag = printFlag;
	}

	public String getForeignSn() {
		return foreignSn;
	}

	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

	/**
	 * @return the payTypeName
	 */
	public String getPayTypeName() {
		return payTypeName;
	}

	/**
	 * @param payTypeName the payTypeName to set
	 */
	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	/**
	 * @return the specialFlag
	 */
	public String getSpecialFlag() {
		return specialFlag;
	}

	/**
	 * @param specialFlag the specialFlag to set
	 */
	public void setSpecialFlag(String specialFlag) {
		this.specialFlag = specialFlag;
	}

	/**
	 * @return the specialFlagName
	 */
	public String getSpecialFlagName() {
		return specialFlagName;
	}

	/**
	 * @param specialFlagName the specialFlagName to set
	 */
	public void setSpecialFlagName(String specialFlagName) {
		this.specialFlagName = specialFlagName;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the backFlag
	 */
	public String getBackFlag() {
		return backFlag;
	}

	/**
	 * @param backFlag the backFlag to set
	 */
	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	/**
	 * @return the backFlagName
	 */
	public String getBackFlagName() {
		return backFlagName;
	}

	/**
	 * @param backFlagName the backFlagName to set
	 */
	public void setBackFlagName(String backFlagName) {
		this.backFlagName = backFlagName;
	}

	/**
	 * @return the payFlag
	 */
	public String getPayFlag() {
		return payFlag;
	}

	/**
	 * @param payFlag the payFlag to set
	 */
	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}

	/**
	 * @return the payFlagName
	 */
	public String getPayFlagName() {
		return payFlagName;
	}

	/**
	 * @param payFlagName the payFlagName to set
	 */
	public void setPayFlagName(String payFlagName) {
		this.payFlagName = payFlagName;
	}

	/**
	 * @return the priority
	 */
	public String getPriority() {
		return priority;
	}

	/**
	 * @param priority the priority to set
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}

	@Override
	public String toString() {
		return "BalanceEntity [balanceId=" + balanceId + ", contractNo="
				+ contractNo + ", payType=" + payType + ", initBalance="
				+ initBalance + ", curBalance=" + curBalance + ", preBalance="
				+ preBalance + ", wrtoffMonth=" + wrtoffMonth
				+ ", balanceType=" + balanceType + ", beginTime=" + beginTime
				+ ", endTime=" + endTime + ", payTime=" + payTime + ", paySn="
				+ paySn + ", printFlag=" + printFlag + ", ForeignSn="
				+ foreignSn + "]";
	}
	
	
}
