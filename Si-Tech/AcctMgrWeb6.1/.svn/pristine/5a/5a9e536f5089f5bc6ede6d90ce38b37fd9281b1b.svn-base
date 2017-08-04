package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S2312CfmInDTO extends CommonInDTO{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.QUES, type = "String", len = "1", desc = "操作类型", memo = "1：添加；2：修改；3：删除")
	String opType = "";
	@ParamDesc(path = "BUSI_INFO.REGION_CODE", cons = ConsType.QUES, type = "String", len = "10", desc = "地市", memo = "")
	String regionCode = "";
	@ParamDesc(path = "BUSI_INFO.LEVEL", cons = ConsType.QUES, type = "String", len = "1", desc = "星级", memo = "")
	String level = "";
	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "开始时间", memo = "")
	String beginTime = "";
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "结束时间", memo = "")
	String endTime = "";
	@ParamDesc(path = "BUSI_INFO.HOLIDAY_NAME", cons = ConsType.QUES, type = "String", len = "40", desc = "节假日名称", memo = "")
	String holidayName = "";
	@ParamDesc(path = "BUSI_INFO.OP_NOTE", cons = ConsType.QUES, type = "String", len = "100", desc = "操作备注", memo = "")
	String  opNote= "";
	@ParamDesc(path = "BUSI_INFO.OLD_REGION_CODE", cons = ConsType.QUES, type = "String", len = "10", desc = "地市", memo = "")
	String oldRegionCode = "";
	@ParamDesc(path = "BUSI_INFO.OLD_LEVEL", cons = ConsType.QUES, type = "String", len = "1", desc = "星级", memo = "")
	String oldLevel = "";
	@ParamDesc(path = "BUSI_INFO.OLD_BEGIN_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "开始时间", memo = "")
	String oldBeginTime = "";
	@ParamDesc(path = "BUSI_INFO.OLD_END_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "结束时间", memo = "")
	String oldEndTime = "";

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setLevel(arg0.getStr(getPathByProperName("level")));
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
		setHolidayName(arg0.getStr(getPathByProperName("holidayName")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		setOldRegionCode(arg0.getStr(getPathByProperName("oldRegionCode")));
		setOldLevel(arg0.getStr(getPathByProperName("oldLevel")));
		setOldBeginTime(arg0.getStr(getPathByProperName("oldBeginTime")));
		setOldEndTime(arg0.getStr(getPathByProperName("oldEndTime")));
	}

	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the level
	 */
	public String getLevel() {
		return level;
	}

	/**
	 * @param level the level to set
	 */
	public void setLevel(String level) {
		this.level = level;
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

	/**
	 * @return the holidayName
	 */
	public String getHolidayName() {
		return holidayName;
	}

	/**
	 * @param holidayName the holidayName to set
	 */
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	/**
	 * @return the oldRegionCode
	 */
	public String getOldRegionCode() {
		return oldRegionCode;
	}

	/**
	 * @param oldRegionCode the oldRegionCode to set
	 */
	public void setOldRegionCode(String oldRegionCode) {
		this.oldRegionCode = oldRegionCode;
	}

	/**
	 * @return the oldLevel
	 */
	public String getOldLevel() {
		return oldLevel;
	}

	/**
	 * @param oldLevel the oldLevel to set
	 */
	public void setOldLevel(String oldLevel) {
		this.oldLevel = oldLevel;
	}

	/**
	 * @return the oldBeginTime
	 */
	public String getOldBeginTime() {
		return oldBeginTime;
	}

	/**
	 * @param oldBeginTime the oldBeginTime to set
	 */
	public void setOldBeginTime(String oldBeginTime) {
		this.oldBeginTime = oldBeginTime;
	}

	/**
	 * @return the oldEndTime
	 */
	public String getOldEndTime() {
		return oldEndTime;
	}

	/**
	 * @param oldEndTime the oldEndTime to set
	 */
	public void setOldEndTime(String oldEndTime) {
		this.oldEndTime = oldEndTime;
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
}
