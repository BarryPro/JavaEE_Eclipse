package com.sitech.acctmgr.inter.pay;

import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @Title:  总对总缴费冲正 [8003]
 * @Description: 总对总缴费冲正 原子服务： 冲正前校验、冲正、记录总对总记录冲正记录表
 * @Date : 20161202
 * @Company: SI-TECH
 * @author : qiaolin
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
public interface IGrpUnifyBack {

	/**
	* 名称：总对总缴费冲正 确认服务
	* @param ORI_REQ_SYS
	* @param ORI_ACTION_DATE
	* @param ORI_TRANSACTION_ID
	* @param REVOKE_REASON
	* @param TRANSACTION_ID
	* @param SETTLE_DATE
	* @param BIP_CODE
	* @param ACTIVITY_CODE
	* @param SESSION_ID
	* @param TRANS_IDO
	* @param TRANS_IDO_TIME
	* @param TRANS_IDH
	* @param TRANS_IDH_TIME
	* @param MSG_SENDER
	* @param MSG_RECEIVER
    * @param  BIP_CODE

	* @return RSP_CODE
	* @return RSP_INFO
	* @return PAYMENT_LIST
	* 				PAY_SN 				<br>
	* 				CONTRACT_NO	<br>
	* 				PHONE_NO			<br>
	* 				PAY_TYPE			
	* @throws BusiException
	* @author qiaolin
	 */
	OutDTO cfm(InDTO inParam);
}
