package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditOpenInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path="BUSI_INFO.ServiceType",cons=ConsType.CT001,type="String",len="2",desc="标识类型",memo="01：手机号码 02：固话号码 03：宽带帐号 04：vip卡号 05：集团编码；本期只有01：手机号码")
	protected String serviceType = "";
	@ParamDesc(path="BUSI_INFO.ServiceNumber",cons=ConsType.CT001,type="String",len="11",desc="标识号码",memo="略")
	protected String serviceNumber = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setServiceType(arg0.getObject(getPathByProperName("serviceType")).toString());
		setServiceNumber(arg0.getObject(getPathByProperName("serviceNumber")).toString());

	
	}

	/**
	 * @return the serviceType
	 */
	public String getServiceType() {
		return serviceType;
	}

	/**
	 * @param serviceType the serviceType to set
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * @return the serviceNumber
	 */
	public String getServiceNumber() {
		return serviceNumber;
	}

	/**
	 * @param serviceNumber the serviceNumber to set
	 */
	public void setServiceNumber(String serviceNumber) {
		this.serviceNumber = serviceNumber;
	}
}

