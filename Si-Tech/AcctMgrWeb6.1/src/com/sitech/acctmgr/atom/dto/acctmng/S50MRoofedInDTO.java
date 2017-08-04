package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S50MRoofedInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4823649763178861971L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="用户号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="1",desc="操作类型",memo="略")
	private String opType;
	@ParamDesc(path="BUSI_INFO.FD_TYPE",cons=ConsType.QUES,type="String",len="1",desc="办理类型",memo="略")
	private String fdType;
	
	public void decode(MBean arg0){
		super.decode(arg0);
				
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());	
		setOpType(arg0.getObject(getPathByProperName("opType")).toString());		
		setFdType(arg0.getObject(getPathByProperName("fdType")).toString());

	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
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
	 * @return the fdType
	 */
	public String getFdType() {
		return fdType;
	}

	/**
	 * @param fdType the fdType to set
	 */
	public void setFdType(String fdType) {
		this.fdType = fdType;
	}
}
