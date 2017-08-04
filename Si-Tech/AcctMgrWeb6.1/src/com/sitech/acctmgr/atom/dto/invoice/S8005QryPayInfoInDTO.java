package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
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
public class S8005QryPayInfoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2437286863730547360L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号", memo = "略")
	protected String phoneNo;

	@ParamDesc(path = "BUSI_INFO.USER_FLAG", cons = ConsType.CT001, type = "string", len = "3", desc = "用户类型", memo = "0:在网用户,1:离网用户")
	protected int userFlag;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.CT001, type = "string", len = "10", desc = "开始日期", memo = "略")
	protected int beginDate;

	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.CT001, type = "string", len = "10", desc = "结束日期", memo = "略")
	protected int endDate;

	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "string", len = "20", desc = "用户ID", memo = "可为空")
	protected long idNo;

	@ParamDesc(path = "BUSI_INFO.ELEC_TYPE", cons = ConsType.QUES, type = "string", len = "2", desc = "电子发票标示", memo = "0：普通纸质，1：电子")
	private int elecType;

	@ParamDesc(path = "BUSI_INFO.QRY_WAY", cons = ConsType.QUES, type = "string", len = "2", desc = "查询方式", memo = "0：按用户加账户查询，1：按账户查询")
	protected int qryWay;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "string", len = "20", desc = "账户号码", memo = "略")
	protected long contractNo;

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getQryWay() {
		return qryWay;
	}

	public void setQryWay(int qryWay) {
		this.qryWay = qryWay;
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

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}

	public int getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	public int getEndDate() {
		return endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	/**
	 * 
	 */
	public S8005QryPayInfoInDTO() {
		// TODO Auto-generated constructor stub
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean) */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("userFlag")))) {
			userFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("userFlag")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))) {
			idNo = ValueUtils.longValue((arg0.getStr(getPathByProperName("idNo"))));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginDate")))) {
			beginDate = Integer.parseInt(arg0.getStr(getPathByProperName("beginDate")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endDate")))) {
			endDate = Integer.parseInt(arg0.getStr(getPathByProperName("endDate")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("elecType")))) {
			elecType = ValueUtils.intValue(arg0.getStr(getPathByProperName("elecType")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("qryWay")))) {
			qryWay = ValueUtils.intValue(arg0.getStr(getPathByProperName("qryWay")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue((arg0.getStr(getPathByProperName("contractNo"))));
		}
	}
}
