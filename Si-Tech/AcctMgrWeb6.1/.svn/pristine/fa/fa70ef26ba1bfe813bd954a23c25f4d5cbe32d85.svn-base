package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8504InitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.FLAG_CODE", cons = ConsType.CT001, desc = "二批代码", len = "10", type = "string", memo = "略")
	private String flagCode;
	
	@ParamDesc(path = "BUSI_INFO.CELL_ID", cons = ConsType.CT001, desc = "基站代码", len = "7", type = "string", memo = "略")
	private String cellId;
	
	@ParamDesc(path = "BUSI_INFO.LAC_CODE", cons = ConsType.CT001, desc = "计费代码", len = "20", type = "string", memo = "略")
	private String lacCode;
	
	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, desc = "查询类型", len = "1", type = "string", memo = "略")
	private String queryType;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("flagCode")))){
			flagCode = arg0.getStr(getPathByProperName("flagCode"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("cellId")))) {
			cellId = arg0.getStr(getPathByProperName("cellId"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("lacCode")))) {
			lacCode = arg0.getStr(getPathByProperName("lacCode"));
		}
		queryType = arg0.getStr(getPathByProperName("queryType"));
		
	}

	/**
	 * @return the flagCode
	 */
	public String getFlagCode() {
		return flagCode;
	}

	/**
	 * @param flagCode the flagCode to set
	 */
	public void setFlagCode(String flagCode) {
		this.flagCode = flagCode;
	}

	/**
	 * @return the cellId
	 */
	public String getCellId() {
		return cellId;
	}

	/**
	 * @param cellId the cellId to set
	 */
	public void setCellId(String cellId) {
		this.cellId = cellId;
	}

	/**
	 * @return the lacCode
	 */
	public String getLacCode() {
		return lacCode;
	}

	/**
	 * @param lacCode the lacCode to set
	 */
	public void setLacCode(String lacCode) {
		this.lacCode = lacCode;
	}

	/**
	 * @return the queryType
	 */
	public String getQueryType() {
		return queryType;
	}

	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}
}
