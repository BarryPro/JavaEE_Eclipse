package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.account.AccountEntity;
import com.sitech.acctmgr.atom.domains.query.familyEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/21.
 */
public class SFeeQueryBalanceQueryOutDTO extends CommonOutDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "预存款", memo = "单位：分")
	private long prepayFee;

	@ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "欠费", memo = "单位：分")
	private long oweFee;

	@ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "滞纳金", memo = "单位：分")
	private long delayFee;

	@ParamDesc(path = "EXPIRE_TIME", cons = ConsType.CT001, type = "String", len = "18", desc = "有效期时间", memo = "格式：yyyyMMDDHHMISS")
	private String expireTime;

	@ParamDesc(path = "BEGIN_FLAG", cons = ConsType.CT001, type = "String", len = "18", desc = "开始时间标志", memo = "Y：激活   N：未激活")
	private String beginFlag;

	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "帐户名称", memo = "略")
	private String contractName;

	@ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "客户名称", memo = "略")
	private String custName;

	@ParamDesc(path = "PAY_CODE", cons = ConsType.CT001, type = "String", len = "1", desc = "支付类型", memo = "与PAY_NAME相对应")
	private String payCode;

	@ParamDesc(path = "PAY_NAME", cons = ConsType.CT001, type = "String", len = "30", desc = "支付类型名称", memo = "略")
	private String payName;

	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "未出帐欠费", memo = "单位：分")
	private long unbillOwe;

	@ParamDesc(path = "BRAND_ID", cons = ConsType.CT001, type = "String", len = "6", desc = "品牌ID", memo = "略")
	private String brandId;

	@ParamDesc(path = "BRAND_NAME", cons = ConsType.CT001, type = "String", len = "30", desc = "品牌名称", memo = "略")
	private String brandName;

	@ParamDesc(path = "SPEC_PREPAY", cons = ConsType.CT001, type = "long", len = "14", desc = "专款预存", memo = "单位：分")
	private long specPrepay;

	@ParamDesc(path = "NORMAL_PREPAY", cons = ConsType.CT001, type = "long", len = "14", desc = "普通预存", memo = "单位：分")
	private long normalPrepay;

	@ParamDesc(path = "HAS_LOWEST", cons = ConsType.CT001, type = "String", len = "1", desc = "是否有底线", memo = "取值Y：有最低消费；N：无最低消费；")
	private String hasLowest;

	@ParamDesc(path = "LOWEST_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "底限费用", memo = "单位：分")
	private long lowestFee;

	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "当前余额", memo = "单位：分")
	private long remainFee;

	@ParamDesc(path = "AWOKE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "提醒余额阀值", memo = "单位：分")
	private long awokeFee;

	@ParamDesc(path = "ACCOUNT_LIST", cons = ConsType.QUES, type = "complex", len = "30", desc = "包年或托收账户列表", memo = "略")
	private List<AccountEntity> accountList;
	
	//增加家庭主副卡查询
	@ParamDesc(path = "MAIN_PHONE", cons = ConsType.CT001, type = "String", len = "15", desc = "主卡号码", memo = "略")
	private String mainPhone;
	@ParamDesc(path = "MAIN_UNBILL", cons = ConsType.CT001, type = "long", len = "15", desc = "主卡未出账话费", memo = "单位:分")
	private long mainUnBill;
	@ParamDesc(path = "FAMILY_LIST", cons = ConsType.QUES, type = "complex", len = "1", desc = "家庭成员未出账话费列表", memo = "略")
	private List<familyEntity> familyList;

	@Override
	public MBean encode() {
		MBean bean = super.encode();
		bean.setRoot(getPathByProperName("prepayFee"), prepayFee);
		bean.setRoot(getPathByProperName("oweFee"), oweFee);
		bean.setRoot(getPathByProperName("delayFee"), delayFee);
		bean.setRoot(getPathByProperName("expireTime"), expireTime);
		bean.setRoot(getPathByProperName("beginFlag"), beginFlag);
		bean.setRoot(getPathByProperName("contractName"), contractName);
		bean.setRoot(getPathByProperName("custName"), custName);
		bean.setRoot(getPathByProperName("payCode"), payCode);
		bean.setRoot(getPathByProperName("payName"), payName);
		bean.setRoot(getPathByProperName("unbillOwe"), unbillOwe);
		bean.setRoot(getPathByProperName("brandId"), brandId);
		bean.setRoot(getPathByProperName("brandName"), brandName);
		bean.setRoot(getPathByProperName("specPrepay"), specPrepay);
		bean.setRoot(getPathByProperName("normalPrepay"), normalPrepay);
		bean.setRoot(getPathByProperName("hasLowest"), hasLowest);
		bean.setRoot(getPathByProperName("lowestFee"), lowestFee);
		bean.setRoot(getPathByProperName("remainFee"), remainFee);
		bean.setRoot(getPathByProperName("accountList"), accountList);
		bean.setRoot(getPathByProperName("awokeFee"), awokeFee);
		
		bean.setRoot(getPathByProperName("mainPhone"), mainPhone);
		bean.setRoot(getPathByProperName("mainUnBill"), mainUnBill);
		bean.setRoot(getPathByProperName("familyList"), familyList);

		return bean;
	}

	public long getAwokeFee() {
		return awokeFee;
	}

	public void setAwokeFee(long awokeFee) {
		this.awokeFee = awokeFee;
	}

	public String getBeginFlag() {
		return beginFlag;
	}

	public void setBeginFlag(String beginFlag) {
		this.beginFlag = beginFlag;
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

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getPayName() {
		return payName;
	}

	public void setPayName(String payName) {
		this.payName = payName;
	}

	public long getUnbillOwe() {
		return unbillOwe;
	}

	public void setUnbillOwe(long unbillOwe) {
		this.unbillOwe = unbillOwe;
	}

	public String getBrandId() {
		return brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getHasLowest() {
		return hasLowest;
	}

	public void setHasLowest(String hasLowest) {
		this.hasLowest = hasLowest;
	}

	public long getLowestFee() {
		return lowestFee;
	}

	public void setLowestFee(long lowestFee) {
		this.lowestFee = lowestFee;
	}

	public List<AccountEntity> getAccountList() {
		return accountList;
	}

	public void setAccountList(List<AccountEntity> accountList) {
		this.accountList = accountList;
	}

	public long getSpecPrepay() {
		return specPrepay;
	}

	public void setSpecPrepay(long specPrepay) {
		this.specPrepay = specPrepay;
	}

	public long getNormalPrepay() {
		return normalPrepay;
	}

	public void setNormalPrepay(long normalPrepay) {
		this.normalPrepay = normalPrepay;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the mainPhone
	 */
	public String getMainPhone() {
		return mainPhone;
	}

	/**
	 * @param mainPhone the mainPhone to set
	 */
	public void setMainPhone(String mainPhone) {
		this.mainPhone = mainPhone;
	}

	/**
	 * @return the mainUnBill
	 */
	public long getMainUnBill() {
		return mainUnBill;
	}

	/**
	 * @param mainUnBill the mainUnBill to set
	 */
	public void setMainUnBill(long mainUnBill) {
		this.mainUnBill = mainUnBill;
	}

	/**
	 * @return the familyList
	 */
	public List<familyEntity> getFamilyList() {
		return familyList;
	}

	/**
	 * @param familyList the familyList to set
	 */
	public void setFamilyList(List<familyEntity> familyList) {
		this.familyList = familyList;
	}
}
