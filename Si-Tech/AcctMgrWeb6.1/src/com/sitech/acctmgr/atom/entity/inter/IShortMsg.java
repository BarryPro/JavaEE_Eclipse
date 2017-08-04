package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.pub.pubUpdateEntity;

/**
 *
 * <p>Title: 用户下发短信管理  </p>
 * <p>Description: 主要管理用户下发短信提醒号码相关功能  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface IShortMsg {

	/**
	 * 名称：获取账户缴费默认下发短信号码（没有取到配置的情况下），没有返回null
	 * @author qiaolin
	 */
	public abstract String getConSmsPhone(long contractNo);
	
	
	/**
	 * 名称：是否配置缴费下发短信号码
	 */
	public abstract boolean isConfig(long contractNo);
	
	public abstract void inShortMsgInfo(Map<String, Object> inParam);
	
	public abstract void dConfig(long contractNo);
	
	public abstract List<Map<String, Object>> getShortMsgList(String phoneNo, Long contractNo);
	
	public abstract void inShortMsgInfoHis(long contractNo, pubUpdateEntity updateEntity);
	
	public abstract void upPhone(long contractNo, String phoneNo);
}
