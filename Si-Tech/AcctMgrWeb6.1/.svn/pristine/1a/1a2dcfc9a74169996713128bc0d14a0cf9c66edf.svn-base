package com.sitech.acctmgr.atom.entity.inter;

import java.util.Map;

/**
 *
 * <p>Title: 代理商接口  </p>
 * <p>Description: 查询代理商基本信息 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface IAgent {

	/**
	 * 名称：查询代理商号码
	 * @param loginNo
	 * @return phoneNo
	 * @author qiaolin
	 */
	public abstract String getAgentPhone(String loginNo);
	
	/**
	 * 名称：查询空中充值账户
	 * @param phoneNo
	 * @return 空中充值代理商账户，如果没有找到，则返回0
	 * @author qiaolin
	 */
	public abstract long getAgentCon(String phoneNo);
	
	/**
	 * 名称：判断是否空中充值代理商号码
	 * @param idNo
	 * @return boolean  是空中充值代理商返回true，不是返回faluse  
	 * @author qiaolin
	 */
	public abstract boolean isKcAgentPhone(Long idNo);
	
	
	/**
	 * 名称：判断是否空中充值代理商号码
	 * @param idNo
	 * @return boolean  是空中充值代理商返回true，不是返回faluse  
	 * @author qiaolin
	 */
	public abstract boolean isKcAgentPhone(String PhoneNo);
	
	public abstract boolean isKcAgentPhone(String phoneNo, String contractNo);
	
	/**
	 * 名称：查询空中充值代理商信息
	 * @param IDNo
	 * @return LIMIT_FEE, AGENT_CODE
	 * @author qiaolin
	 */
	public abstract Map<String, Object> getAgentInfo(long IdNo);
	
	/**
	 * 名称：查询空中充值代理商信息
	 * @param phoneNo
	 * @return 
	 * @author qiaolin
	 */
	public abstract Map<String, Object> getAgentInfo(String phoneNo);
	
	/**
	 * 名称：判断是否联动优势代理商号码
	 * @param phoneNo
	 * @return boolean  是联动优势代理商返回true，不是返回faluse  
	 * @author qiaolin
	 */
	public abstract boolean isLdysAgentPhone(String phoneNo);
	
	/**
	 * 名称：获取空中充值代理商当天缴费金额
	 * @param agentPhone
	 * @return 金额
	 * @author qiaolin
	 */
	public abstract long getSumKcPayfee(String agentPhone);
	
	/**
	 * 名称：获取区县下空中充值代理商列表,分页
	 * @param districtGroupId
	 * @param pageNum	:第几也
	 * @param flag      : 1除去已经审核通过允许网厅缴费号码
	 * @return Map 中 result 存放List<AgentEntity>  sum 存放总行数
	 * @author qiaolin
	 */
	public abstract Map<String, Object> getDistrictAgentList(String districtGroupId, int pageNum, String provinceId, String flag);
	
	
}
