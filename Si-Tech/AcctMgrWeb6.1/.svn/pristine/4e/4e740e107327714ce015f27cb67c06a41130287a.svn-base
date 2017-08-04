package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SOweIotQryInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	
	@ParamDesc(path="BUSI_INFO.LOG_CODE",cons=ConsType.CT001,type="String",len="40",desc="日志编码",memo="略")
	private String logCode = "";
	
	@ParamDesc(path="BUSI_INFO.ORDER_NO",cons=ConsType.CT001,type="String",len="40",desc="业务订购号",memo="略")
	private String orderNo = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		logCode = arg0.getStr(getPathByProperName("logCode"));
		orderNo = arg0.getStr(getPathByProperName("orderNo"));
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
	 * @return the logCode
	 */
	public String getLogCode() {
		return logCode;
	}

	/**
	 * @param logCode the logCode to set
	 */
	public void setLogCode(String logCode) {
		this.logCode = logCode;
	}

	/**
	 * @return the orderNo
	 */
	public String getOrderNo() {
		return orderNo;
	}

	/**
	 * @param orderNo the orderNo to set
	 */
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
}
