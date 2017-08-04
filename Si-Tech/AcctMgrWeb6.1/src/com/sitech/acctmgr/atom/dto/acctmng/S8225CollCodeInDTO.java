/**
 * 
 */
package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @author wangyla
 *
 */
public class S8225CollCodeInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7413482913007291563L;
	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.CT001, desc = "操作类型", len = "1", type = "string", memo = "略")
	private String opType = "";
	@ParamDesc(path = "BUSI_INFO.CODE_ID", cons = ConsType.QUES, desc = "返回代码", len = "4", type = "string", memo = "略")
	private String codeId = "";
	@ParamDesc(path = "BUSI_INFO.CODE_VALUE", cons = ConsType.QUES, desc = "返回名称", len = "20", type = "string", memo = "略")
	private String codeValue = "";
	@ParamDesc(path = "BUSI_INFO.STATUS", cons = ConsType.QUES, desc = "重托标志,1重托，0不重托 （操作类型为u，a时必传）", len = "1", type = "string", memo = "略")
	private String collStatus = "";
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		opType = arg0.getStr(getPathByProperName("opType"));
		codeId = arg0.getStr(getPathByProperName("codeId"));
		codeValue = arg0.getStr(getPathByProperName("codeValue"));
		collStatus = arg0.getStr(getPathByProperName("collStatus"));
	}
	
	public String getOpType() {
		return opType;
	}


	public void setOpType(String opType) {
		this.opType = opType;
	}


	public String getCodeId() {
		return codeId;
	}


	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}


	public String getCodeValue() {
		return codeValue;
	}


	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}


	public String getCollStatus() {
		return collStatus;
	}


	public void setCollStatus(String collStatus) {
		this.collStatus = collStatus;
	}
	
}
