package com.sitech.acctmgr.atom.dto.cct;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8288GrpInitOutDTO extends CommonOutDTO{

	@JSONField(name="UNIT_ID")
	@ParamDesc(path="UNIT_ID",cons=ConsType.CT001,type="String",len="40",desc="集团编码",memo="略")
	protected	String unitId;	
	@JSONField(name="CREDIT_CODE")
	@ParamDesc(path="CREDIT_CODE",cons=ConsType.CT001,type="String",len="5",desc="信用等级",memo="略")
	protected	String creditCode;	
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="40",desc="开始时间",memo="略")
	protected	String beginTime;
	@JSONField(name="END_TIME")
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="40",desc="结束时间",memo="略")
	protected	String endTime;
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="10",desc="业务代码",memo="略")
	protected	String opCode;
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="40",desc="操作工号",memo="略")
	protected	String loginNo;
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="40",desc="操作时间",memo="略")
	protected	String opTime;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("unitId"), unitId);
		result.setRoot(getPathByProperName("creditCode"), creditCode);
		result.setRoot(getPathByProperName("beginTime"), beginTime);
		result.setRoot(getPathByProperName("endTime"), endTime);
		result.setRoot(getPathByProperName("opCode"), opCode);
		result.setRoot(getPathByProperName("loginNo"), loginNo);
		result.setRoot(getPathByProperName("opTime"), opTime);
		return result;
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

	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}

	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
}
