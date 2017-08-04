package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 
* @Title:   []
* @Description: 
* @Date : 2016年3月8日下午2:04:09
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public interface I8008 {
	
	
	
	/**
	 * 名称: 宽带退预存款查询
	 * @param SERVICE_NO:宽带号
	 * 
	 * @return CONTRACT_NO:账户
	 * @return PHONE_NO:号码
	 */
	OutDTO broadband (InDTO inParam);
	/**
	* 名称：退预存款查询
	* @param LOGIN_NO:：工号 
	* @param GROUP_ID:：归属 
	* @param PHONE_NO:：号码
	* @param CONTRACT_NO：账户 
	* @param IN_IF_ONNET：在离网标识
	* 
	* @return RETURN_CODE：返回代码
	* @return RETURN_MSG：返回信息
	* @return RETURN_MONEY：可退金额
	* @return UNBILL_TOTAL：总欠费
	* @return UNBILL_TOTAL：账户名称
	* @return UNBILL_TOTAL：结算利息
	* @throws Exception
	 */
	OutDTO init (InDTO inParam);

 
	
	/**
	* 名称：退预存款:查询不可退预存
	* @param CONTRACT_NO：账号
	* @param IN_IF_ONNET：在离网标识
	* 
	* @return RETURN_CODE：返回代码
	* @return RETURN_MSG：返回信息
	* @throws Exception
	 */
	OutDTO noBackMoney (InDTO inParam);
	
	/**
	* 名称：退预存款确认
	* @param LOGIN_NO：工号
	* @param GROUP_ID：归属
	* @param PHONE_NO：号码
	* @param CONTRACT_NO：账户
	* @param PAY_MONEY：退费金额
	* @param NOTE：备注
	* @param IF_ONNET： 1 在网，2离网
	* @param PAY_PATH：缴费渠道   联动空中充值传入
	* @param PAY_METHOD：缴费方式  联动空中充值传入
	* 
	* @return RETURN_CODE：返回代码
	* @return RETURN_MSG：返回信息
	* @throws Exception
	 */
	OutDTO cfm (InDTO inParam);
}
