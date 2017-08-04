package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 入参DTO
 * </p>
 * <p>
 * Description: 从入参报文获取参数，并检验入参的正确性
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
public class SPubCodeInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7576238614539520962L;

	protected String sCodeClass;
	protected String sCodeId;
	protected String sCodeValue;
	protected String sPGroupId;

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		sCodeClass = arg0.getBodyStr("BUSI_INFO.CODE_CLASS");
		if (StringUtils.isNotEmptyOrNull(arg0.getBodyStr("BUSI_INFO.CODE_ID"))) {
			sCodeId = arg0.getBodyStr("BUSI_INFO.CODE_ID");
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getBodyStr("BUSI_INFO.CODE_VALUE"))) {
			sCodeValue = arg0.getBodyStr("BUSI_INFO.CODE_VALUE");
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getBodyStr("BUSI_INFO.GROUP_ID"))) {
			sPGroupId = arg0.getBodyStr("BUSI_INFO.GROUP_ID");
		}

	}

	/**
	 * @return the sCodeClass
	 */
	public String getsCodeClass() {
		return sCodeClass;
	}

	/**
	 * @param sCodeClass
	 *            the sCodeClass to set
	 */
	public void setsCodeClass(String sCodeClass) {
		this.sCodeClass = sCodeClass;
	}

	/**
	 * @return the sCodeId
	 */
	public String getsCodeId() {
		return sCodeId;
	}

	/**
	 * @param sCodeId
	 *            the sCodeId to set
	 */
	public void setsCodeId(String sCodeId) {
		this.sCodeId = sCodeId;
	}

	/**
	 * @return the sCodeValue
	 */
	public String getsCodeValue() {
		return sCodeValue;
	}

	/**
	 * @param sCodeValue
	 *            the sCodeValue to set
	 */
	public void setsCodeValue(String sCodeValue) {
		this.sCodeValue = sCodeValue;
	}

	/**
	 * @return the sPGroupId
	 */
	public String getsPGroupId() {
		return sPGroupId;
	}

	/**
	 * @param sPGroupId
	 *            the sPGroupId to set
	 */
	public void setsPGroupId(String sPGroupId) {
		this.sPGroupId = sPGroupId;
	}

}
