package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 陈死账查询入参DTO
 * </p>
 * <p>
 * Description: 陈死账查询入参DTO
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhangjp
 * @version 1.0
 */
public class S8109InDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5961590252161851952L;
	/**
	 * 
	 */
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
	protected String phoneNo = "";
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "账户ID", memo = "略")
	protected long contractNo = 0;
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "用户ID", memo = "略")
	protected long idNo = 0;
	
	@ParamDesc(path = "BUSI_INFO.ID_ICCID", cons = ConsType.CT001, type = "String", len = "20", desc = "身份证号码", memo = "略")
	protected String idIccid = "";
	/*
	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "账单类型", memo = "1:按手机号码查询;2:按身份证号码查询")
	protected String opType = "";
	*/
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(arg0.getObject(getPathByProperName("phoneNo")) != null && !arg0.getObject(getPathByProperName("phoneNo")).equals("")) {
			setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		}
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")) {
			setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));
		}
		if(arg0.getObject(getPathByProperName("idNo")) != null && !arg0.getObject(getPathByProperName("idNo")).equals("")) {
			setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		}
			
		//setOpType(arg0.getStr(getPathByProperName("opType")));
		if(arg0.getObject(getPathByProperName("idIccid")) != null && !arg0.getObject(getPathByProperName("idIccid")).equals("")) {
			setIdIccid(arg0.getStr(getPathByProperName("idIccid")));
		}
			
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

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the idIccid
	 */
	public String getIdIccid() {
		return idIccid;
	}

	/**
	 * @param idIccid the idIccid to set
	 */
	public void setIdIccid(String idIccid) {
		this.idIccid = idIccid;
	}



}