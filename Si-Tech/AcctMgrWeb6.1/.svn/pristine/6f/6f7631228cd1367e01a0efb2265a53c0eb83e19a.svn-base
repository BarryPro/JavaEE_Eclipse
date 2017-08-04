package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.hsf.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8510InDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="100",desc="操作类型",memo="1：办理；0：查询")
	private String opType;
	@ParamDesc(path="BUSI_INFO.FD_TYPE",cons=ConsType.QUES,type="String",len="100",desc="操作类型",memo="0：办理不封顶；1：取消封顶")
	private String fdType;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setFdType(arg0.getStr(getPathByProperName("fdType")));
		
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
