package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditCfmInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
	String phoneNo = "";
	@ParamDesc(path = "BUSI_INFO.CUST_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "客户名称", memo = "略")
	String custName = "";
	@ParamDesc(path = "BUSI_INFO.CUST_ICID", cons = ConsType.CT001, type = "String", len = "20", desc = "身份证号码", memo = "略")
	String custIcid = "";
	@ParamDesc(path = "BUSI_INFO.REMIND_PHONE", cons = ConsType.CT001, type = "String", len = "20", desc = "预留联系号码", memo = "略")
	String remindPhone = "";
	/*
	@ParamDesc(path = "BUSI_INFO.CHN_CODE", cons = ConsType.CT001, type = "String", len = "18", desc = "渠道代码 01-营业，02-网厅，04-短信，05-自助终端", memo = "略")
	String chnCode;
	*/

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		custName = arg0.getStr(getPathByProperName("custName"));
		custIcid = arg0.getStr(getPathByProperName("custIcid"));
		remindPhone = arg0.getStr(getPathByProperName("remindPhone"));

	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
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
	 * @return the custIcid
	 */
	public String getCustIcid() {
		return custIcid;
	}

	/**
	 * @param custIcid the custIcid to set
	 */
	public void setCustIcid(String custIcid) {
		this.custIcid = custIcid;
	}

	/**
	 * @return the remindPhone
	 */
	public String getRemindPhone() {
		return remindPhone;
	}

	/**
	 * @param remindPhone the remindPhone to set
	 */
	public void setRemindPhone(String remindPhone) {
		this.remindPhone = remindPhone;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
