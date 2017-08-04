package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8288GrpCfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8311086839080877424L;

	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="40",desc="集团编码",memo="略")
	private String unitId;
	@ParamDesc(path="BUSI_INFO.CREDIT_CODE",cons=ConsType.QUES,type="String",len="5",desc="信用等级",memo="略")
	private String creditCode;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.QUES,type="String",len="40",desc="开始时间",memo="略")
	private String beginTime;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.QUES,type="String",len="40",desc="结束时间",memo="略")
	private String endTime;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());
		setCreditCode(arg0.getObject(getPathByProperName("creditCode")).toString());
		setBeginTime(arg0.getObject(getPathByProperName("beginTime")).toString());
		setEndTime(arg0.getObject(getPathByProperName("endTime")).toString());
	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	/**
	 * @return the creditCode
	 */
	public String getCreditCode() {
		return creditCode;
	}

	/**
	 * @param creditCode the creditCode to set
	 */
	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
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
