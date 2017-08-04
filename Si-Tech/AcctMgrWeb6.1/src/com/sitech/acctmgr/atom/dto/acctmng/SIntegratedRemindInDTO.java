package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SIntegratedRemindInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="用户号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="1",desc="操作类型",memo="A:开通；D:关闭")
	private String opType;
	@ParamDesc(path="BUSI_INFO.OP_FLAG",cons=ConsType.QUES,type="String",len="1",desc="业务标识",memo="0:短信业务;4:语音业务;5:彩信业务;9:日高额提醒业务")
	private String opFlag;
	
	public void decode(MBean arg0){
		super.decode(arg0);
				
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());	
		setOpType(arg0.getObject(getPathByProperName("opType")).toString());		
		setOpFlag(arg0.getObject(getPathByProperName("opFlag")).toString());
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
	 * @return the opFlag
	 */
	public String getOpFlag() {
		return opFlag;
	}

	/**
	 * @param opFlag the opFlag to set
	 */
	public void setOpFlag(String opFlag) {
		this.opFlag = opFlag;
	}

}
