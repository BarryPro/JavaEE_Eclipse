package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:  陈死账回收接口 </p>
* <p>Description:  陈死账回收接口 </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface I8006 {
	/**
	* 名称： 陈死账查询：查询用户陈死账账单信息及用户基本信息
	* @param OPR_INFO.LOGIN_NO 工号
	* @param OPR_INFO.OP_CODE	 操作代码
	* @param OPR_INFO.GROUP_ID	 工号归属
	* 
	* @param BUSI_INFO.PHONE_NO
	* @param BUSI_INFO.ID_NO
	* @param BUSI_INFO.OP_TYPE 陈死账类型
	* @return
	* @return 
	* @throws Exception
	* @author guowy
	*/
	OutDTO init(final InDTO inParam);
	
	/**
	* 名称： 陈死账回收确认
	* @param OPR_INFO. 
	* @param OPR_INFO.	
	* 
	* @param BUSI_INFO
	* 
	* @return
	* @return OUT_DATA
	*
	* @throws Exception
	* @author guowy
	*/
	OutDTO cfm(InDTO inParam);

}
