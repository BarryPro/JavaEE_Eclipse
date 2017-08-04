package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.anno.ConsType;

/**
 *
 * <p>Title: 缴费查询类服务输出用户资料展示对象  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class PayOutUserData {

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
	
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="账户名称",memo="略")
	private String contractName;
	
	@JSONField(name="LIMIT_OWE")
	@ParamDesc(path="LIMIT_OWE",cons=ConsType.CT001,type="long",len="18",desc="信用度",memo="略")
	private long limitOwe;
	
	@JSONField(name="RUN_CODE")
	@ParamDesc(path="RUN_CODE",cons=ConsType.CT001,type="String",len="2",desc="运行状态",memo="略")
	private String runCode;
	
	@JSONField(name="RUN_NAME")
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="String",len="64",desc="运行状态名称",memo="略")
	private String runName;
	
	@JSONField(name="REGION_ID")
	@ParamDesc(path="REGION_ID",cons=ConsType.CT001,type="String",len="100",desc="用户归属地市",memo="略")
	private String regionId;
	
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="100",desc="用户归属地市名称",memo="略")
	private String regionName;
	
	@JSONField(name="USER_GROUP_NAME")
	@ParamDesc(path="USER_GROUP_NAME",cons=ConsType.CT001,type="String",len="100",desc="归属组织机构名称",memo="略")
	private String userGroupName;
	
	@JSONField(name="PRODUCT_NAME")
	@ParamDesc(path="PRODUCT_NAME",cons=ConsType.CT001,type="String",len="120",desc="主产品名称",memo="略")
	private String productName = "";
	
	@JSONField(name="BRAND_NAME")
	@ParamDesc(path="BRAND_NAME",cons=ConsType.CT001,type="String",len="64",desc="品牌名称",memo="略")
	private String brandName;
	
	@JSONField(name="CONTRACTATT_TYPE")
	@ParamDesc(path="CONTRACTATT_TYPE",cons=ConsType.CT001,type="String",len="2",desc="账户类型",memo="略")
	private String contractattType;
	
	@JSONField(name="CONTRACTATT_TYPE_NAME")
	@ParamDesc(path="CONTRACTATT_TYPE_NAME",cons=ConsType.CT001,type="String",len="18",desc="账户类型名称",memo="略")
	private String contractattTypeName;
	
	@JSONField(name="USER_NAME")
	@ParamDesc(path="USER_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户名称",memo="略")
	private String custName;
	
	@JSONField(name="CUST_TYPE_NAME")
	@ParamDesc(path="CUST_TYPE_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户等级名称",memo="略")
	private String custLevelName;
	
	@JSONField(name="PAY_CODE")
	@ParamDesc(path="PAY_CODE",cons=ConsType.CT001,type="String",len="2",desc="付费类型",memo="略")
	private String payCode;
	
	@JSONField(name="PAY_CODE_NAME")
	@ParamDesc(path="PAY_CODE_NAME",cons=ConsType.CT001,type="String",len="64",desc="付费类型名称",memo="略")
	private String paycodeName;
	
	@JSONField(name="OWER_TYPE_NAME")
	@ParamDesc(path="OWER_TYPE_NAME",cons=ConsType.CT001,type="String",len="1",desc="用户类型，1：个人 2：家庭 3：集团 4：团体",memo="略")
	private String owerTypeName;
	
	@JSONField(name="USER_CNT")
	@ParamDesc(path="USER_CNT",cons=ConsType.CT001,type="int",len="8",desc="付费用户数",memo="略")
	private int userCnt;
	
	@JSONField(name="BRAND_ID")
	@ParamDesc(path="BRAND_ID",cons=ConsType.CT001,type="String",len="6",desc="用户品牌ID",memo="略")
	private String brandId;
	
	@JSONField(name="IS_4G")
	@ParamDesc(path="IS_4G",cons=ConsType.CT001,type="String",len="2",desc="是否为4G用户",memo="略")
	private String is4G;

	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PayOutUserData [phoneNo=" + phoneNo + ", contractNo=" + contractNo + ", contractName=" + contractName + ", limitOwe="
				+ limitOwe + ", runCode=" + runCode + ", runName=" + runName + ", regionId=" + regionId + ", regionName=" + regionName
				+ ", userGroupName=" + userGroupName + ", productName=" + productName + ", brandName=" + brandName + ", contractattType="
				+ contractattType + ", contractattTypeName=" + contractattTypeName + ", custName=" + custName + ", custLevelName="
				+ custLevelName + ", payCode=" + payCode + ", paycodeName=" + paycodeName + ", owerTypeName=" + owerTypeName + ", userCnt="
				+ userCnt + ", brandId=" + brandId + ", is4G=" + is4G + "]";
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	public String getContractName() {
		return contractName;
	}


	public void setContractName(String contractName) {
		this.contractName = contractName;
	}


	public long getLimitOwe() {
		return limitOwe;
	}


	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}


	public String getRunCode() {
		return runCode;
	}


	public void setRunCode(String runCode) {
		this.runCode = runCode;
	}


	public String getRunName() {
		return runName;
	}


	public void setRunName(String runName) {
		this.runName = runName;
	}


	public String getRegionId() {
		return regionId;
	}


	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}


	public String getRegionName() {
		return regionName;
	}


	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}


	public String getUserGroupName() {
		return userGroupName;
	}


	public void setUserGroupName(String userGroupName) {
		this.userGroupName = userGroupName;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getBrandName() {
		return brandName;
	}


	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}


	public String getContractattType() {
		return contractattType;
	}


	public void setContractattType(String contractattType) {
		this.contractattType = contractattType;
	}


	public String getContractattTypeName() {
		return contractattTypeName;
	}


	public void setContractattTypeName(String contractattTypeName) {
		this.contractattTypeName = contractattTypeName;
	}


	public String getCustName() {
		return custName;
	}


	public void setCustName(String custName) {
		this.custName = custName;
	}


	public String getCustLevelName() {
		return custLevelName;
	}


	public void setCustLevelName(String custLevelName) {
		this.custLevelName = custLevelName;
	}


	public String getPayCode() {
		return payCode;
	}


	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}


	public String getPaycodeName() {
		return paycodeName;
	}


	public void setPaycodeName(String paycodeName) {
		this.paycodeName = paycodeName;
	}


	public String getOwerTypeName() {
		return owerTypeName;
	}


	public void setOwerTypeName(String owerTypeName) {
		this.owerTypeName = owerTypeName;
	}


	public int getUserCnt() {
		return userCnt;
	}


	public void setUserCnt(int userCnt) {
		this.userCnt = userCnt;
	}


	public String getBrandId() {
		return brandId;
	}


	public String getIs4G() {
		return is4G;
	}


	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}


	public void setIs4G(String is4g) {
		is4G = is4g;
	}
	
}
