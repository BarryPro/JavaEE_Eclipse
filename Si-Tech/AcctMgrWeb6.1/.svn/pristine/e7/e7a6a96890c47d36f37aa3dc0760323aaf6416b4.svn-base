package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8258CfmInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.QUES, type = "string", len = "20", desc = "集团编码", memo = "略")
	long unitId = 0;	
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "long", len = "18", desc = "用户ID", memo = "略")
	long idNo = 0;
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "18", desc = "账户ID", memo = "略")
	long contractNo = 0;
	@ParamDesc(path = "BUSI_INFO.RED_TYPE", cons = ConsType.QUES, type = "String", len = "1", desc = "信用等级", memo = "略")
	String redType = "";
	@ParamDesc(path = "BUSI_INFO.MONTH_LENGTH", cons = ConsType.QUES, type = "String", len = "10", desc = "延长年月", memo = "略")
	String monthLength = "";


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		super.decode(arg0);
		unitId = Long.parseLong(arg0.getStr(getPathByProperName("unitId")));
		idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		redType = arg0.getStr(getPathByProperName("redType"));
		monthLength = arg0.getStr(getPathByProperName("monthLength"));
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
	 * @return the monthLength
	 */
	public String getMonthLength() {
		return monthLength;
	}


	/**
	 * @param monthLength the monthLength to set
	 */
	public void setMonthLength(String monthLength) {
		this.monthLength = monthLength;
	}


	/**
	 * @return the redType
	 */
	public String getRedType() {
		return redType;
	}


	/**
	 * @param redType the redType to set
	 */
	public void setRedType(String redType) {
		this.redType = redType;
	}
}
