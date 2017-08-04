package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 集团客户欠费信息查询入参
 * </p>
 * <p>
 * Description: 集团客户欠费信息查询入参
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl_bj
 * @version 1.0
 */
public class S8177InDTO extends CommonInDTO {

	private static final long serialVersionUID = -5961590252161851952L;

	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, type = "String", len = "40", desc = "查询类型", memo = "0：集团编码  1：产品账号")
	protected String qryType;
	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.STAR, type = "long", len = "18", desc = "集团编码", memo = "略")
	protected String unitId;
	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "long", len = "18", desc = "欠费年月", memo = "略")
	protected String yearMonth;
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.STAR, type = "String", len = "1", desc = "账号", memo = "")
	protected long contractNo;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setQryType(arg0.getStr(getPathByProperName("qryType")));

		if (arg0.getStr(getPathByProperName("contractNo")) != null && !arg0.getStr(getPathByProperName("contractNo")).equals("")) {
			setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));
		}

		if (arg0.getStr(getPathByProperName("unitId")) != null && !arg0.getStr(getPathByProperName("unitId")).equals("")) {
			setUnitId(arg0.getStr(getPathByProperName("unitId")));
		}

		setYearMonth(arg0.getStr(getPathByProperName("yearMonth")));
	}

	public String getQryType() {
		return qryType;
	}

	public void setQryType(String qryType) {
		this.qryType = qryType;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

}