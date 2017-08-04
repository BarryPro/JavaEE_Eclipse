package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 资金冲正  </p>
 * <p>Description: 完成多种缴费、退费处理的统一冲正功能  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface I8056 {
	
	/**
	* 名称：根据帐户信息去查询流水信息
	* @param LOGIN_NO         : 工号，非空
	* @param GROUP_ID		  : 工号组织机构归属，非空
	* @param OP_CODE          : 模块编码，写死传入8003
	* @param CONTRACT_NO      : 账户ID
	* @return PAYSN_LIST.PAY_FEE	<br/>
	* 		  PAYSN_LIST.PAY_SN		<br/>
	* 		  PAYSN_LIST.TOTAL_DATE	<br/>
	* 		  PAYSN_LIST.PAY_TIME	<br/>
	* 		  PAYSN_LIST.LOGIN_NO	<br/>
	* 	   	  PAYSN_LIST.OP_CODE	<br/>
	* 		  PAYSN_LIST.FUNCTION_NAME <br/>
	* @author qiaolin
	*/
	OutDTO getSnInfo(InDTO inParam);
	
	/**
	* 名称：缴费冲正查询
	* @param LOGIN_NO
	* @param LOGIN_PASSWORD
	* @param PAY_DATE		  : 要冲正的缴费记录的缴费时间
	* @param PAY_SN			  : 要冲正的缴费流水
	* @param OP_CODE          : 模块编码，写死传入8056

	* @return 
	* @author qiaolin
	*/
	OutDTO init(InDTO inParam);
	
	/**
	* 名称：缴费冲正确认	</br>
	* 流程：	</br>
	* 1、冲正现金费用：包括回退冲销账单、入账记录、入账金额、开关机	</br>
	* 2、回退缴费记录和营业员操作记录	</br>
	* @param LOGIN_NO         : 工号，非空
	* @param PHONE_NO
	* @param PAY_DATE		  : 要冲正的缴费记录的缴费时间
	* @param PAY_SN			  : 要重整的缴费流水
	* @param PAY_PATH
	* @param PAY_METHOD
	* @param OP_CODE          : 模块编码，写死传入8003
	* @param SMS_FLAG		  : 默认为0：不发短信，其他：发短信
	* @param PAY_NOTE		  : 备注（可空）

	* @return LOGIN_ACCEPT	  :	冲正流水	</br>
	* 		  TOTAL_DATE	  :	冲正日期	</br>
	* @author qiaolin
	*/
	OutDTO cfm(InDTO inParam);
	
	/**
	* 名称：外部流水缴费冲正确认	</br>
	* 流程：	</br>
	*  根据外部流水获取内部到账流水，调用冲正原子服务进行冲正	</br>
	* @param LOGIN_NO         : 工号，非空
	* @param OP_CODE          : 模块编码，写死传入8003
	* @param PHONE_NO
	* @param PAY_DATE		  : 要冲正的缴费记录的缴费时间
	* @param FOREIGN_SN		  : 要冲正的外部流水
	* @param PAY_PATH
	* @param PAY_METHOD
	* @param PAY_NOTE		  : 备注（可空）

	* @return LOGIN_ACCEPT	  :	冲正流水	</br>
	* 		  TOTAL_DATE	  :	冲正日期	</br>
	* @author qiaolin
	*/
	OutDTO foreign(InDTO inParam);
	
	/**
	* 名称：缴费冲正校验，提供给外部接口	</br>
	* 流程：	</br>
	*  根据外部流水校验能否进行这笔业务的冲正，校验点：	</br>
	*  1、此笔流水的正向业务是否处理成功</br>
	*  2、BOSS侧校验是否能够冲正</br>
	* @param LOGIN_NO         : 工号，非空
	* @param OP_CODE          : 模块编码
	* @param PAY_DATE		  : 要冲正的缴费记录的缴费时间YYYYMMDD
	* @param FOREIGN_SN		  : 要冲正的外部流水

	* @return RETURN_CODE	  :	错误码为0，则可以冲正，不能冲正的时候错误信息中的是不能冲正原因	</br>
	* @author qiaolin
	*/
	OutDTO check(InDTO inParam);
	
	
	
	
	/**
	* 名称：集团红包充值转账冲正	</br>
	* 功能：对于I8014Svc_grpcfm 操作的冲正
	* 流程：	</br>
	* 1、冲正红包：包括回退入账记录、入账金额、出账记录、出账金额	</br>
	* 2、回退缴费记录和营业员操作记录	</br>
	* @param LOGIN_NO         : 工号，非空
	* @param PHONE_NO         ：转入帐号
	* @param PAY_DATE		  : 红包充值时间
	* @param PAY_SN 		  : 需要冲正的流水
	* @param FOREIGN_SN       ：外部流水
	* @param GROUP_PHONE_NO   ：集团号码（虚拟20号码）
	* @param CONTRACT_NO 	  : 集团产品账号
	* @param PAY_PATH		  : 渠道
	* @param PAY_METHOD		  : 缴费方式
	* @return LOGIN_ACCEPT	  :	冲正流水	</br>
	* 		  TOTAL_DATE	  :	冲正日期	</br>
	* @author hanfl
	*/
	OutDTO grpTrnsBank(InDTO inParam);
	
}
