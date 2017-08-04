package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 单个号码补收接口  </p>
* <p>Description:  单个号码补收包括查询和确认服务  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface I8010 {

	/**
	* 名称：补收查询服务,
	* @param OPR_INFO.OP_CODE: 模块代码
	* @param OPR_INFO.LOGIN_NO工号，非空
	* @param BUSI_INFO.PHONE_NO：服务号码 ，非空
	* @param BUSI_INFO.CONTRACT_NO：帐户号码，非空
	* 
	* @return RUN_NAME：运行状态
	* @return CUST_NAME：账户名称
	* @return CUST_INFO：账户信息
	* @throws Exception
	 */
	 OutDTO init(final InDTO inParam);
	 

	 /**
		* 名称：补收确认服务,
		* @param LOGIN_NO工号，非空
		* @param REGIPN_CODE：地市编码 非空
		* @param OP_CODE: 模块代码 非空
		* @param PHONE_NO：服务号码 ，非空
		* @param CONTRACT_NO：帐户号码，非空
		* @param BILL_MONTH：补收年月 非空
		* @param TOTAL_PAY：补收总金额
		* @param PAY_DETAIL：补收详细 --补收名称|补收金额|#
		* @param IN_NOTE  ：交费备注，可空
		* 
		* @return 
		* @throws Exception
		 */
	 OutDTO cfm(final InDTO inParam);
	 
	 /**
		* 名称：宽带补收的资费标识
		* 
		* @return 
		* @throws Exception
		 */
	 OutDTO getItem(final InDTO inParam);
	 
	 /**
		* 名称：查询送费明细
		* 
		* @return 
		* @throws Exception
		 */
	 OutDTO queryGiveInfo(final InDTO inParam);
	 
}
