package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2103891920904478032L;
	
	@ParamDesc(path="PHONE_NO",cons= ConsType.CT001,type="string",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_CODE",cons=ConsType.CT001,type="string",len="4",desc="业务代码",memo="略")
	private String busiCode;
	@ParamDesc(path="BUSI_MSG",cons=ConsType.CT001,type="string",len="60",desc="业务名称",memo="略")
	private String busiMsg;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("busiCode"), busiCode);
		result.setRoot(getPathByProperName("busiMsg"), busiMsg);
		return result;
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
	 * @return the busiCode
	 */
	public String getBusiCode() {
		return busiCode;
	}

	/**
	 * @param busiCode the busiCode to set
	 */
	public void setBusiCode(String busiCode) {
		this.busiCode = busiCode;
	}

	/**
	 * @return the busiMsg
	 */
	public String getBusiMsg() {
		return busiMsg;
	}

	/**
	 * @param busiMsg the busiMsg to set
	 */
	public void setBusiMsg(String busiMsg) {
		this.busiMsg = busiMsg;
	}

}
