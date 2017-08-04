package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.common.utils.StringUtils;

public class S8120QryInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="1",desc="查询类型",memo="0：边界漫游;1:相邻小区")
	private String opType;
	@ParamDesc(path="BUSI_INFO.MSC_ID",cons=ConsType.QUES,type="String",len="20",desc="漫游MSC_ID",memo="")
	private String mscId;
	@ParamDesc(path="BUSI_INFO.LAC_ID",cons=ConsType.QUES,type="String",len="20",desc="漫游LAC_ID",memo="")
	private String lacId;
	@ParamDesc(path="BUSI_INFO.CELL_ID",cons=ConsType.QUES,type="String",len="20",desc="漫游CELL_ID",memo="")
	private String cellId;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.QUES,type="String",len="8",desc="开始时间",memo="")
	private String beginTime;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.QUES,type="String",len="8",desc="结束时间",memo="")
	private String endTime;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setOpType(arg0.getStr(getPathByProperName("opType")));
		if(StringUtils.isNotEmptyOrNull((arg0.getStr(getPathByProperName("mscId"))))){
			setMscId(arg0.getObject(getPathByProperName("mscId")).toString());
		}
		if(StringUtils.isNotEmptyOrNull((arg0.getStr(getPathByProperName("lacId"))))){
			setLacId(arg0.getObject(getPathByProperName("lacId")).toString());
		}
		if(StringUtils.isNotEmptyOrNull((arg0.getStr(getPathByProperName("cellId"))))){
			setCellId(arg0.getObject(getPathByProperName("cellId")).toString());
		}
		if(StringUtils.isNotEmptyOrNull((arg0.getStr(getPathByProperName("beginTime"))))){
			setBeginTime(arg0.getObject(getPathByProperName("beginTime")).toString());
		}		
		if(StringUtils.isNotEmptyOrNull((arg0.getStr(getPathByProperName("endTime"))))){
			setEndTime(arg0.getObject(getPathByProperName("endTime")).toString());
		}
		

	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}

	/**
	 * @return the mscId
	 */
	public String getMscId() {
		return mscId;
	}

	/**
	 * @param mscId the mscId to set
	 */
	public void setMscId(String mscId) {
		this.mscId = mscId;
	}

	/**
	 * @return the lacId
	 */
	public String getLacId() {
		return lacId;
	}

	/**
	 * @param lacId the lacId to set
	 */
	public void setLacId(String lacId) {
		this.lacId = lacId;
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
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}
