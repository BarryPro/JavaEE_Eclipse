package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.AgentEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S2302InitOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "AGENT_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "空中充值代理商列表", memo = "略")
	private List<AgentEntity> agentList = null;

	@ParamDesc(path = "TOTAL_NUM", cons = ConsType.QUES, type = "string", len = "10", desc = "总条数，用于分页", memo = "略")
	private int totalNum;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("agentList"), agentList);
		result.setRoot(getPathByProperName("totalNum"), totalNum);
		log.info(result.toString());
		return result;
	}

	public List<AgentEntity> getAgentList() {
		return agentList;
	}

	public void setAgentList(List<AgentEntity> agentList) {
		this.agentList = agentList;
	}

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

}
