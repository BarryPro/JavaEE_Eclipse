package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 退预存款
 * </p>
 * <p>
 * Description: 将String入参解析成MBean格式
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author LIJXD
 * @version 1.0
 */
public class SCreateOrderInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6530513105591434857L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "14", desc = "服务号码", memo = "略")
	protected String phoneNo;
	@ParamDesc(path = "BUSI_INFO.PAY_MONEY", cons = ConsType.CT001, type = "String", len = "12", desc = "金额", memo = "略")
	protected String payMoney;
	@ParamDesc(path = "BUSI_INFO.OP_NOTE", cons = ConsType.QUES, type = "String", len = "3", desc = "备注", memo = "略")
	protected String opNote;

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPayMoney(arg0.getStr(getPathByProperName("payMoney")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @return the payMoney
	 */
	public String getPayMoney() {
		return payMoney;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @param payMoney
	 *            the payMoney to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @param opNote
	 *            the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}
