package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 催欠冲正接口  </p>
* <p>Description: 催欠冲正查询、确认接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public interface I8080 {
	
	
	/**
	* 名称：根据工号和流水查陈死账询缴费信息
	* @param OPR_INFO.LOGIN_NO 工号
	* @param OPR_INFO.LOGIN_ACCEPT	缴费流水
	* 
	* @return 
	* @throws Exception
	* @author liuyc_billing
	*/
	OutDTO queryPayInfo(final InDTO inParam);
	
	/**
	* 名称： 催欠冲正确认
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
	OutDTO backCfm(InDTO inParam);

}
