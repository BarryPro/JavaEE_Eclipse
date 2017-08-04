package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: sp查询入参信息  </p>
 * <p>Description: sp查询入参DTO  </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8041SpInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6266162698185891674L;
	
	@ParamDesc(path = "BUSI_INFO.SPID", cons = ConsType.CT001, desc = "企业代码", len = "20", type = "string", memo = "略")
	private String spid;
	@ParamDesc(path = "BUSI_INFO.SERVNAME", cons = ConsType.CT001, desc = "业务名称", len = "64", type = "string", memo = "略")
	protected String servName;
	
	 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setSpid(arg0.getStr(getPathByProperName("spid")));
		setServName(arg0.getStr(getPathByProperName("servName")).trim());
	}


	/**
	 * @return the spid
	 */
	public String getSpid() {
		return spid;
	}


	/**
	 * @param spid the spid to set
	 */
	public void setSpid(String spid) {
		this.spid = spid;
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

	 

}
