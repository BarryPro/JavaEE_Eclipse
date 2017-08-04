package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAgentOprDmInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4080242291751279890L;
	@ParamDesc(path="BUSI_INFO.AGT_PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="代理商号码",memo="略")
	protected String agtPhoneNo = "";
	@ParamDesc(path="BUSI_INFO.LOGIN_PASSWD",cons=ConsType.QUES,type="String",len="20",desc="工号密码",memo="略")
	protected String loginPasswd = "";
	@ParamDesc(path="BUSI_INFO.AGENT_PASSWD",cons=ConsType.QUES,type="String",len="10",desc="代理商账户密码",memo="略")
	protected String agentPasswd = "";
	@ParamDesc(path="BUSI_INFO.QUERY_FLAG",cons=ConsType.QUES,type="String",len="1",desc="查询方式",memo="0：查询当日；1：查询当月")
	protected String queryFlag = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setAgtPhoneNo(arg0.getObject(getPathByProperName("agtPhoneNo")).toString());
		setLoginPasswd(arg0.getObject(getPathByProperName("loginPasswd")).toString());
		setAgentPasswd(arg0.getObject(getPathByProperName("agentPasswd")).toString());
		setQueryFlag(arg0.getObject(getPathByProperName("queryFlag")).toString());

	}

	/**
	 * @return the agtPhoneNo
	 */
	public String getAgtPhoneNo() {
		return agtPhoneNo;
	}

	/**
	 * @param agtPhoneNo the agtPhoneNo to set
	 */
	public void setAgtPhoneNo(String agtPhoneNo) {
		this.agtPhoneNo = agtPhoneNo;
	}

	/**
	 * @return the loginPasswd
	 */
	public String getLoginPasswd() {
		return loginPasswd;
	}

	/**
	 * @param loginPasswd the loginPasswd to set
	 */
	public void setLoginPasswd(String loginPasswd) {
		this.loginPasswd = loginPasswd;
	}

	/**
	 * @return the agentPasswd
	 */
	public String getAgentPasswd() {
		return agentPasswd;
	}

	/**
	 * @param agentPasswd the agentPasswd to set
	 */
	public void setAgentPasswd(String agentPasswd) {
		this.agentPasswd = agentPasswd;
	}

	/**
	 * @return the queryFlag
	 */
	public String getQueryFlag() {
		return queryFlag;
	}

	/**
	 * @param queryFlag the queryFlag to set
	 */
	public void setQueryFlag(String queryFlag) {
		this.queryFlag = queryFlag;
	}
}
