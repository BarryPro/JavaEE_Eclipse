package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8008BbdInDTO extends CommonInDTO{

	/**
	 * <p>Title: 宽带退预存款 00 </p>
	 * <p>Description:  将String入参解析成MBean格式 </p>
	 * <p>Copyright: Copyright (c) 2016</p>
	 * <p>Company: SI-TECH </p>
	 * @author SUZJ
	 * @version 1.0
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.SERVICE_NO",cons=ConsType.CT001,type="String",len="40",desc="宽带号码",memo="略")
	protected String serviceNo;
	
	@ParamDesc(path="BUSI_INFO.IN_IF_ONNET",cons=ConsType.CT001,type="String",len="1",desc="在网标识",memo="1:在网；2:离网")
	protected String inIfOnNet;
	
	@ParamDesc(path="BUSI_INFO.BBD_TYPE",cons=ConsType.CT001,type="String",len="1",desc="宽带类型标识",memo="0:普通宽带；1:铁通宽带;2:8010宽带查询")
	protected String bbdType;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setServiceNo(arg0.getStr(getPathByProperName("serviceNo")));
		setInIfOnNet(arg0.getStr(getPathByProperName("inIfOnNet")));
		setBbdType(arg0.getStr(getPathByProperName("bbdType")));
	}
	/**
	 * @return the serviceNo
	 */
	public String getServiceNo() {
		return serviceNo;
	}
	/**
	 * @param serviceNo the serviceNo to set
	 */
	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}
	
	/**
	 * @return the bbdType
	 */
	public String getBbdType() {
		return bbdType;
	}
	/**
	 * @param bbdType the bbdType to set
	 */
	public void setBbdType(String bbdType) {
		this.bbdType = bbdType;
	}
	
	
	/**
	 * @return the inIfOnNet
	 */
	public String getInIfOnNet() {
		return inIfOnNet;
	}
	/**
	 * @param inIfOnNet the inIfOnNet to set
	 */
	public void setInIfOnNet(String inIfOnNet) {
		this.inIfOnNet = inIfOnNet;
	}
	
	

	
}
