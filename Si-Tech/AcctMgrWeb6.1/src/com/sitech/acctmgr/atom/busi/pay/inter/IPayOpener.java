package com.sitech.acctmgr.atom.busi.pay.inter;

import java.util.Map;

import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IPayOpener {

	/**
	 * 名称：账户开机，循环账户下用户，为其做开机	</br>
	 * 流程：	 </br>
	 * 1.取余额</br>
	 * 2.开机判断</br>
	 * 3.状态变更</br>
	 * 4.发服务开通</br>
	 * @param PHONE_NO		：缴费用户，可空
	 * @param CONTRACT_NO	：缴费账户
	 * @param PAY_SN		：缴费流水
	 * @param OP_CODE		
	 * @param LOGIN_NO
	 * @param LOGIN_GROUP
	 * @param CONTACT_ID	：统一流水，可空
	 * 
	 * @author qiaolin
	 */
	public abstract void doConUserOpen(Map<String, Object> Header, PayUserBaseEntity userBase, PayBookEntity inBook, String provinceId);

	/**
	 * 名称：更新标准神州行有效期
	 * @param	ID_NO
	 * @param 	PHONE_NO
	 * @param 	BRAND_ID
	 * @param 	REGION_CODE	: 用户地市代码
	 * @param 	PAY_SN
	 * @param	PAY_MONEY
	 * @param	LOGIN_NO
	 * @param	OP_CODE
	 * @param	CUR_TIME
	 * @param	TOTAL_DATE
	 * @param	CONTACT_ID	:端到端流水，可空
	
	 * @author qiaolin
	 */
	public abstract void updateExpireTime(Map<String, Object> inParam);
	
	/**
	 * 名称：取消标准神州行用户余额有效期限制
	 * @param	TOTAL_DATE
	 * @param	ID_NO
	 * 
	 * @author  liuyc_billing
	 */
	public abstract void cancelExpireTime(Map<String, Object> inParam);
	
	/**
	 * 名称：更新催缴信息
	 * @param	lIdNo
	 * @param   flag		: 更新标识, 0: 缴清欠费  1: 信誉度+缴费>欠费  2: 无欠费缴费
	
	 * @return 成功返回true,失败false
	 * @author qiaolin
	 */
	public abstract boolean upAwokeTime (long lIdNo, int flag);
	
	
}