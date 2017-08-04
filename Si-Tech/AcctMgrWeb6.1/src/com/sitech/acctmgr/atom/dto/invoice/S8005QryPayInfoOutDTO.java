package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.PayInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

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
public class S8005QryPayInfoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7632155663233630019L;

	/**
	 * 
	 */
	public S8005QryPayInfoOutDTO() {
		// TODO Auto-generated constructor stub
	}

	@JSONField(name = "PAY_INFO")
	@ParamDesc(path = "PAY_INFO", cons = ConsType.PLUS, type = "compx", len = "1", desc = "缴费信息列表", memo = "略")
	private List<PayInfoEntity> payInfoList = new ArrayList<PayInfoEntity>();

	@JSONField(name = "CUST_ADDRESS")
	@ParamDesc(path = "CUST_ADDRESS", cons = ConsType.PLUS, type = "String", len = "100", desc = "客户地址", memo = "略")
	private String custAddress;

	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.PLUS, type = "String", len = "100", desc = "客户名称", memo = "略")
	private String custName;

	@JSONField(name = "RUN_NAME")
	@ParamDesc(path = "RUN_NAME", cons = ConsType.PLUS, type = "String", len = "50", desc = "运行状态", memo = "略")
	private String runName;

	@JSONField(name = "BRAND_ID")
	@ParamDesc(path = "BRAND_ID", cons = ConsType.PLUS, type = "String", len = "10", desc = "品牌", memo = "略")
	private String brandId;

	@JSONField(name = "CUR_PREPAY_FEE")
	@ParamDesc(path = "CUR_PREPAY_FEE", cons = ConsType.PLUS, type = "long", len = "10", desc = "可用预存", memo = "略")
	private long curPrepayFee;

	@JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.PLUS, type = "long", len = "10", desc = "可用欠费", memo = "略")
	private long oweFee;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.PLUS, type = "long", len = "10", desc = "未出账话费", memo = "略")
	private long unBillFee;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("payInfoList"), payInfoList);
		result.setRoot(getPathByProperName("custAddress"), custAddress);
		result.setRoot(getPathByProperName("runName"), runName);
		result.setRoot(getPathByProperName("curPrepayFee"), curPrepayFee);
		result.setRoot(getPathByProperName("oweFee"), oweFee);
		result.setRoot(getPathByProperName("unBillFee"), unBillFee);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("brandId"), brandId);
		return result;
	}

	public String getBrandId() {
		return brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public List<PayInfoEntity> getPayInfoList() {
		return payInfoList;
	}

	public void setPayInfoList(List<PayInfoEntity> payInfoList) {
		this.payInfoList = payInfoList;
	}

	public String getCustAddress() {
		return custAddress;
	}

	public void setCustAddress(String custAddress) {
		this.custAddress = custAddress;
	}

	public String getRunName() {
		return runName;
	}

	public void setRunName(String runName) {
		this.runName = runName;
	}

	public long getCurPrepayFee() {
		return curPrepayFee;
	}

	public void setCurPrepayFee(long curPrepayFee) {
		this.curPrepayFee = curPrepayFee;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	public long getUnBillFee() {
		return unBillFee;
	}

	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

}
