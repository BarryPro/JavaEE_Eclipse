package com.sitech.acctmgrint.atom.busi.intface;

import com.sitech.jcfx.dt.MBean;

/**
 * 
 * <p>Title: BOSS服务开通统一接口——短信发送接口</p>
 * <p>Description: BOSS服务开通统一接口，JAVA版本供前端服务调用，另有C版本供后台调用</p>
 * <p>Copyright: Copyright (c) 2006</p>
 * <p>Company: SI-TECH </p>
 * @author konglj
 * @version 1.0
 *
 */
public interface IShortMessage {
	

	/**
	 * 名称：发送短信接口
	* @param inLevel 短信等级,默认0，中级
	* 				 (1=高，2=中，3=低，4=群发，5=测试，非必传，默认中级，默认为0)
	* @param inParam MBean类型,包含下列参数：
	* @param	Header:端到端流水，鹰眼系统
	* @param	TRACE_ID		需要新生成
	* @param	PARENT_CALL_ID	上端的TRACE_ID
	* @param	Body:
	* @param	TEMPLATE_ID 短信模板,必传
	* @param	PHONE_NO    服务号码,必传
	* @param	CHECK_FLAG  是否检查替换参数,必传(BOOLEAN:true or false)
	* @param	SEND_TIME	发送时间(YYYYMMDDHH24MISS)，非必传，默认当前时间
	* @param	LOGIN_NO	登陆工号，非必传
	* @param	OP_CODE     操作代码，非必传
	* @param    SEND_FLAG   是否发送标示，非必传，默认0 (0:发送 1:插入短信接口错误表)
	* @param	DATA.XXX    模板中需要替换的参数列Map,必传
	* @return true/false
	* @不抛异常 0001:模板异常 0002:参数异常 0003:其他 0004:发送异常 1111:send_flag=1
	 */
	public Boolean sendSmsMsg(MBean inMessage);
	public Boolean sendSmsMsg(MBean inMessage,int iLevel);
	public String getMsgSeq(String string);

}
