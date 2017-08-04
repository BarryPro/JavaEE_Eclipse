package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
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
public class S8107QueryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7854650798272104577L;
	
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="20",desc="余额",memo="略")
	private long remainFee = 0;
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="预存",memo="略")
	private long curPrepay = 0;
	@ParamDesc(path="UN_PREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="未生效预存",memo="略")
	private long unPrepay = 0;
	@ParamDesc(path="LIMIT_OWE",cons=ConsType.CT001,type="long",len="20",desc="信誉度",memo="略")
	private long limitOwe = 0;
	@ParamDesc(path="CREDIT_CLASS",cons=ConsType.CT001,type="String",len="100",desc="账户等级",memo="略")
	private String creditClass = "";
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费",memo="略")
	private long oweFee = 0;
	@ParamDesc(path="PROD_PRC_NAME",cons=ConsType.CT001,type="String",len="100",desc="套餐类型名称",memo="略")
	private String prodPrcName = "";
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="256",desc="归属地",memo="略")
	private String regionName = "";
	@ParamDesc(path="EXPIRE_TIME",cons=ConsType.CT001,type="String",len="100",desc="有效期",memo="略")
	private String expireTime = "";
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户名称",memo="略")
	private String custName = "";
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="账户名称",memo="略")
	private String contractName = "";
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="String",len="50",desc="付款方式",memo="略")
	private String payName = "";
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="String",len="50",desc="运行状态",memo="略")
	private String runName = "";
	@ParamDesc(path="USER_GRADE_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户等级名称",memo="略")
	private String userGradeName = "";
	@ParamDesc(path="UNBILL_FEE",cons=ConsType.CT001,type="long",len="20",desc="内存欠费",memo="略")
	private long unBillFee = 0;
	@ParamDesc(path="MONTH_UNBILL",cons=ConsType.CT001,type="long",len="20",desc="当月消费",memo="略")
	private long monthUnbill = 0;
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="DEAD_OWE",cons=ConsType.CT001,type="long",len="20",desc="呆坏账金额",memo="略")
	private long deadOwe = 0;
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户ID",memo="略")
	private long idNo = 0;
	@ParamDesc(path="OPEN_FLAG",cons=ConsType.CT001,type="String",len="50",desc="是否二次入网",memo="略")
	private String openFlag = "";
	@ParamDesc(path="OPEN_MONTH",cons=ConsType.CT001,type="String",len="50",desc="开户年月",memo="略")
	private String openMonth = "";
	@ParamDesc(path="OPEN_TIME",cons=ConsType.CT001,type="String",len="100",desc="入网时间",memo="YYYYMMDD")
	private String openTime = "";
	@ParamDesc(path="OPEN_TIME_FOR",cons=ConsType.CT001,type="String",len="100",desc="入网时间",memo="YYYY/MM/DD")
	private String openTimeFor = "";
	@ParamDesc(path="DEAD_INNET_TIME",cons=ConsType.CT001,type="String",len="100",desc="离网用户入网时间",memo="略")
	private String deadInnetTime = "";
	@ParamDesc(path="DEAD_RUN_TIME",cons=ConsType.CT001,type="String",len="100",desc="离网时间",memo="略")
	private String deadRunTime = "";
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	
	@ParamDesc(path="UNIT_ID",cons=ConsType.CT001,type="long",len="20",desc="集团编码",memo="略")
	private long unitId = 0;
	@ParamDesc(path="CUST_ID",cons=ConsType.CT001,type="long",len="20",desc="集团客户ID",memo="略")
	private long custId = 0;
	@ParamDesc(path="CUST_LEVEL",cons=ConsType.CT001,type="String",len="20",desc="集团类别",memo="略")
	private String custLevel = "";
	@ParamDesc(path="UNIT_NAME",cons=ConsType.CT001,type="String",len="20",desc="集团客户名称",memo="略")
	private String unitName = "";
	@ParamDesc(path="STAFF_LOGIN_NAME",cons=ConsType.CT001,type="String",len="20",desc="客户经理名称",memo="略")
	private String staffLoginName = "";
	@ParamDesc(path="STAFF_LOGIN",cons=ConsType.CT001,type="String",len="20",desc="客户经理工号",memo="略")
	private String staffLogin = "";
	@ParamDesc(path="PRODUCT_NAME",cons=ConsType.CT001,type="String",len="20",desc="集团产品名称",memo="略")
	private String productName = "";
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		result.setRoot(getPathByProperName("curPrepay"), curPrepay);
		result.setRoot(getPathByProperName("unPrepay"), unPrepay);
		result.setRoot(getPathByProperName("limitOwe"), limitOwe);
		result.setRoot(getPathByProperName("creditClass"), creditClass);
		result.setRoot(getPathByProperName("oweFee"), oweFee);
		result.setRoot(getPathByProperName("prodPrcName"), prodPrcName);
		result.setRoot(getPathByProperName("regionName"), regionName);
		result.setRoot(getPathByProperName("expireTime"), expireTime);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("contractName"), contractName);
		result.setRoot(getPathByProperName("payName"), payName);
		result.setRoot(getPathByProperName("runName"), runName);
		result.setRoot(getPathByProperName("userGradeName"), userGradeName);
		result.setRoot(getPathByProperName("unBillFee"), unBillFee);
		result.setRoot(getPathByProperName("monthUnbill"), monthUnbill);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("deadOwe"), deadOwe);
		result.setRoot(getPathByProperName("idNo"), idNo);
		result.setRoot(getPathByProperName("openFlag"), openFlag);
		result.setRoot(getPathByProperName("openMonth"), openMonth);
		result.setRoot(getPathByProperName("openTime"), openTime);
		result.setRoot(getPathByProperName("openTimeFor"), openTimeFor);
		result.setRoot(getPathByProperName("deadInnetTime"), deadInnetTime);
		result.setRoot(getPathByProperName("deadRunTime"), deadRunTime);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		
		result.setRoot(getPathByProperName("unitId"), unitId);
		result.setRoot(getPathByProperName("custId"), custId);
		result.setRoot(getPathByProperName("custLevel"), custLevel);
		result.setRoot(getPathByProperName("unitName"), unitName);
		result.setRoot(getPathByProperName("staffLoginName"), staffLoginName);
		result.setRoot(getPathByProperName("staffLogin"), staffLogin);
		result.setRoot(getPathByProperName("productName"), productName);
		return result;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the curPrepay
	 */
	public long getCurPrepay() {
		return curPrepay;
	}

	/**
	 * @param curPrepay the curPrepay to set
	 */
	public void setCurPrepay(long curPrepay) {
		this.curPrepay = curPrepay;
	}

	public long getUnPrepay() {
		return unPrepay;
	}

	public void setUnPrepay(long unPrepay) {
		this.unPrepay = unPrepay;
	}

	/**
	 * @return the limitOwe
	 */
	public long getLimitOwe() {
		return limitOwe;
	}

	/**
	 * @param limitOwe the limitOwe to set
	 */
	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}

	/**
	 * @return the creditClass
	 */
	public String getCreditClass() {
		return creditClass;
	}

	/**
	 * @param creditClass the creditClass to set
	 */
	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the prodPrcName
	 */
	public String getProdPrcName() {
		return prodPrcName;
	}

	/**
	 * @param prodPrcName the prodPrcName to set
	 */
	public void setProdPrcName(String prodPrcName) {
		this.prodPrcName = prodPrcName;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @return the expireTime
	 */
	public String getExpireTime() {
		return expireTime;
	}

	/**
	 * @param expireTime the expireTime to set
	 */
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}

	/**
	 * @return the contractName
	 */
	public String getContractName() {
		return contractName;
	}

	/**
	 * @param contractName the contractName to set
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}

	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}

	/**
	 * @return the runName
	 */
	public String getRunName() {
		return runName;
	}

	/**
	 * @param runName the runName to set
	 */
	public void setRunName(String runName) {
		this.runName = runName;
	}

	/**
	 * @return the userGradeName
	 */
	public String getUserGradeName() {
		return userGradeName;
	}

	/**
	 * @param userGradeName the userGradeName to set
	 */
	public void setUserGradeName(String userGradeName) {
		this.userGradeName = userGradeName;
	}

	/**
	 * @return the unBillFee
	 */
	public long getUnBillFee() {
		return unBillFee;
	}

	/**
	 * @param unBillFee the unBillFee to set
	 */
	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	/**
	 * @return the monthUnbill
	 */
	public long getMonthUnbill() {
		return monthUnbill;
	}

	/**
	 * @param monthUnbill the monthUnbill to set
	 */
	public void setMonthUnbill(long monthUnbill) {
		this.monthUnbill = monthUnbill;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the deadOwe
	 */
	public long getDeadOwe() {
		return deadOwe;
	}

	/**
	 * @param deadOwe the deadOwe to set
	 */
	public void setDeadOwe(long deadOwe) {
		this.deadOwe = deadOwe;
	}

	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the openFlag
	 */
	public String getOpenFlag() {
		return openFlag;
	}

	/**
	 * @param openFlag the openFlag to set
	 */
	public void setOpenFlag(String openFlag) {
		this.openFlag = openFlag;
	}

	/**
	 * @return the openMonth
	 */
	public String getOpenMonth() {
		return openMonth;
	}

	/**
	 * @param openMonth the openMonth to set
	 */
	public void setOpenMonth(String openMonth) {
		this.openMonth = openMonth;
	}

	/**
	 * @return the openTime
	 */
	public String getOpenTime() {
		return openTime;
	}

	/**
	 * @param openTime the openTime to set
	 */
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	/**
	 * @return the openTimeFor
	 */
	public String getOpenTimeFor() {
		return openTimeFor;
	}

	/**
	 * @param openTimeFor the openTimeFor to set
	 */
	public void setOpenTimeFor(String openTimeFor) {
		this.openTimeFor = openTimeFor;
	}

	/**
	 * @return the deadInnetTime
	 */
	public String getDeadInnetTime() {
		return deadInnetTime;
	}

	/**
	 * @param deadInnetTime the deadInnetTime to set
	 */
	public void setDeadInnetTime(String deadInnetTime) {
		this.deadInnetTime = deadInnetTime;
	}

	/**
	 * @return the deadRunTime
	 */
	public String getDeadRunTime() {
		return deadRunTime;
	}

	/**
	 * @param deadRunTime the deadRunTime to set
	 */
	public void setDeadRunTime(String deadRunTime) {
		this.deadRunTime = deadRunTime;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the custLevel
	 */
	public String getCustLevel() {
		return custLevel;
	}

	/**
	 * @param custLevel the custLevel to set
	 */
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}

	/**
	 * @return the unitName
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * @param unitName the unitName to set
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * @return the staffLoginName
	 */
	public String getStaffLoginName() {
		return staffLoginName;
	}

	/**
	 * @param staffLoginName the staffLoginName to set
	 */
	public void setStaffLoginName(String staffLoginName) {
		this.staffLoginName = staffLoginName;
	}

	/**
	 * @return the staffLogin
	 */
	public String getStaffLogin() {
		return staffLogin;
	}

	/**
	 * @param staffLogin the staffLogin to set
	 */
	public void setStaffLogin(String staffLogin) {
		this.staffLogin = staffLogin;
	}

	/**
	 * @return the productName
	 */
	public String getProductName() {
		return productName;
	}

	/**
	 * @param productName the productName to set
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}

	/**
	 * @return the unitId
	 */
	public long getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	/**
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}

	/**
	 * @param custId the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}

	
	
}
