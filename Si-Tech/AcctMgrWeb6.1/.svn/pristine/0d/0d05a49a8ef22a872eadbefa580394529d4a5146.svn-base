package com.sitech.acctmgr.atom.busi.pay.inter;

import java.util.Map;

 /**
  * 缴费类接口调用(封装了其他接口)函数，放在此处
 * @Title:   []
 * @Description: 代替组合服务，实现部分提交，部分回滚
 * @Date : 2015年4月9日下午7:02:07
 * @Company: SI-TECH
 * @author : qiaolin
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p>
  */
public interface IPayDoInter {

	 
	 /**
	 * 名称： 调用缴费接口：可以回滚缴费事务
	 * @param 
	 * @return 
	 * @throws Exception
	 * @author LIJXD
	  */
	public abstract Map<String, Object> doS8000Cfm(Map<String, Object> inParam);
	
	/**
	 * 名称：调用外部流水冲正
	 * @param inParam
	 * @return
	 */
	public Map<String, Object> doS8056Foreign(Map<String, Object> inParam);
	
	/**
	 * 
	* 名称：提交事务
	* @param 
	* @return 
	* @throws
	 */
	public abstract void commit();
	
	/**
	 * 
	* 名称：回滚事务
	* @param 
	* @return 
	* @throws
	 */
	public abstract void rollback();
}