package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STellCodeOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="SERV_NAME")
	@ParamDesc(path="SERV_NAME",cons=ConsType.CT001,type="String",len="100",desc="业务名称",memo="")
	protected String servName;
	@JSONField(name="SP_NAME")
	@ParamDesc(path="SP_NAME",cons=ConsType.CT001,type="String",len="100",desc="公司名称",memo="")
	protected String spName;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("servName"), servName);
		result.setRoot(getPathByProperName("spName"), spName);

		return result;
	}

	/**
	 * @return the servName
	 */
	public String getServName() {
		return servName;
	}

	/**
	 * @param servName the servName to set
	 */
	public void setServName(String servName) {
		this.servName = servName;
	}

	/**
	 * @return the spName
	 */
	public String getSpName() {
		return spName;
	}

	/**
	 * @param spName the spName to set
	 */
	public void setSpName(String spName) {
		this.spName = spName;
	}	
}
