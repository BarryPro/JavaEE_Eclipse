package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSmashEggInitInDTO extends CommonInDTO{
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="200",desc="操作备注",memo="略")
	protected String opNote = "";
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.QUES,type="String",len="14",desc="操作流水",memo="略")
	protected String loginAccept = "";
	@ParamDesc(path="BUSI_INFO.CHANNEL_FLAG",cons=ConsType.QUES,type="String",len="2",desc="渠道标识",memo="略")
	protected String channelFlag = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setOpNote(arg0.getObject(getPathByProperName("opNote")).toString());
		setChannelFlag(arg0.getObject(getPathByProperName("channelFlag")).toString());
		setLoginAccept(arg0.getObject(getPathByProperName("loginAccept")).toString());

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
	 * @return the channelFlag
	 */
	public String getChannelFlag() {
		return channelFlag;
	}

	/**
	 * @param channelFlag the channelFlag to set
	 */
	public void setChannelFlag(String channelFlag) {
		this.channelFlag = channelFlag;
	}

	/**
	 * @return the loginAccept
	 */
	public String getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}
	
}
