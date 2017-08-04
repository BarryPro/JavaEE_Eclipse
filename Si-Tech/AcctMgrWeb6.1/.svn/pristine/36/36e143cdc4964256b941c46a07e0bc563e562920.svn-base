package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.AgentEntity;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S2302CfmInDTO extends CommonInDTO {
	
	@ParamDesc(path = "BUSI_INFO.AGENT_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "空中充值代理商列表", memo = "略")
	private List<AgentEntity> agentList = new ArrayList<AgentEntity>();
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		List<Map<String, Object>> listTmp = (List<Map<String, Object>>)arg0.getList(getPathByProperName("agentList"));
		for(Map<String, Object> agentTmp : listTmp){
    		String jsonStr = JSON.toJSONString(agentTmp);
    		this.agentList.add(JSON.parseObject(jsonStr, AgentEntity.class));
		}
		
		String flag = "0";
		for(AgentEntity agent : this.agentList){
			if(agent.getAgentConNo() == 0){
				continue;
			}else{
				flag = "1";
			}
		}
		if(flag.equals("0")){
			throw new BusiException(getErrorCode(opCode, "01003"), "没有选择代理商");
		}
	}

	public List<AgentEntity> getAgentList() {
		return agentList;
	}

	public void setAgentList(List<AgentEntity> agentList) {
		this.agentList = agentList;
	}
}
