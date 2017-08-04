package com.sitech.acctmgr.atom.dto.pay;


import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S2311CfmInDTO extends CommonInDTO{

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.CT001, desc = "开始时间", len = "100", type = "string", memo = "略")
	private String beginDate;
	
	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.CT001, desc = "结束时间", len = "100", type = "string", memo = "")
	protected String endDate;
	
	@ParamDesc(path = "BUSI_INFO.REGION_CODE", cons = ConsType.CT001, desc = "地市", len = "14", type = "string", memo = "略")
	protected String regionCode;
	
	@ParamDesc(path = "BUSI_INFO.OP_LOGIN_NO", cons = ConsType.CT001, desc = "导入工号", len = "14", type = "string", memo = "略")
	protected String opLoginNo;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		setBeginDate(arg0.getStr(getPathByProperName("beginDate")));	
		setEndDate(arg0.getStr(getPathByProperName("endDate")));
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setOpLoginNo(arg0.getStr(getPathByProperName("opLoginNo")));
	}


	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @return the opLoginNo
	 */
	public String getOpLoginNo() {
		return opLoginNo;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @param opLoginNo the opLoginNo to set
	 */
	public void setOpLoginNo(String opLoginNo) {
		this.opLoginNo = opLoginNo;
	}


	/**
	 * @return the beginDate
	 */
	public String getBeginDate() {
		return beginDate;
	}


	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}


	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}


	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


}
