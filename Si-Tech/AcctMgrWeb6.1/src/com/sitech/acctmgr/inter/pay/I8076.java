package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;



/**
*
* <p>Title: 欠费催缴接口  </p>
* <p>Description: 欠费催缴查询接口、确认接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public interface I8076 {
	

	/**
	* 名称：  取有相同号码的欠费清单
	* @param OPR_INFO.LOGIN_NO 工号
	* @param OPR_INFO.OP_CODE	 操作代码
	* @param OPR_INFO.GROUP_ID	 工号归属
	* 
	* @param BUSI_INFO.PHONE_NO
	* @param BUSI_INFO.ID_NO
	* 
	* @return 
	* @throws Exception
	* @author liuyc_billing
	*/
	OutDTO queryUsers(final InDTO inParam);
	
	
	/**
	* 名称：查询用户欠费基本信息
	* @param OPR_INFO.LOGIN_NO 工号
	* @param OPR_INFO.OP_CODE	 操作代码
	* @param OPR_INFO.GROUP_ID	 工号归属
	* 
	* @param BUSI_INFO.PHONE_NO
	* @param BUSI_INFO.ID_NO
	* 
	* @return 
	* @throws Exception
	* @author liuyc_billing
	*/
	OutDTO init(final InDTO inParam);
	
	/**
	* 名称： 欠费催缴确认
	* @param OPR_INFO. 
	* @param OPR_INFO.	
	* 
	* @param BUSI_INFO
	* 
	* @return
	* @return OUT_DATA
	*
	* @throws Exception
	* @author liuyc_billing
	*/
	OutDTO cfm(InDTO inParam);

}
