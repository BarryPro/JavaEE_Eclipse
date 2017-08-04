package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 投诉退费原因维护查询入参信息  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8292QueryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7532002637188018636L;
	
	@ParamDesc(path = "BUSI_INFO.FIRST_CODE", cons = ConsType.CT001, desc = "一级退费原因代码", len = "20", type = "string", memo = "略")
	private String firstCode;
	@ParamDesc(path = "BUSI_INFO.SECOND_CODE", cons = ConsType.QUES, desc = "二级退费原因代码", len = "20", type = "string", memo = "略")
	protected String secondCode;
	@ParamDesc(path = "BUSI_INFO.SP_FLAG", cons = ConsType.CT001, desc = "业务名称", len = "1", type = "string", memo = "1:非sp 2：sp")
	protected String spFlag;
	
	 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setFirstCode(arg0.getStr(getPathByProperName("firstCode")));
		setSecondCode(arg0.getStr(getPathByProperName("secondCode")));
		setSpFlag(arg0.getStr(getPathByProperName("spFlag")));
	}


	/**
	 * @return the firstCode
	 */
	public String getFirstCode() {
		return firstCode;
	}


	/**
	 * @param firstCode the firstCode to set
	 */
	public void setFirstCode(String firstCode) {
		this.firstCode = firstCode;
	}


	/**
	 * @return the secondCode
	 */
	public String getSecondCode() {
		return secondCode;
	}


	/**
	 * @param secondCode the secondCode to set
	 */
	public void setSecondCode(String secondCode) {
		this.secondCode = secondCode;
	}


	/**
	 * @return the spFlag
	 */
	public String getSpFlag() {
		return spFlag;
	}


	/**
	 * @param spFlag the spFlag to set
	 */
	public void setSpFlag(String spFlag) {
		this.spFlag = spFlag;
	}
}
