package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 陈死账回收回退接口  </p>
* <p>Description: 陈死账回收回退查询接口、确认接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface I8007 {

	/**
	* 名称： 陈死账回收回退查询：查询用户陈死账缴费信息
	* @param OPR_INFO.LOGIN_NO 工号
	* @param OPR_INFO.OP_CODE	 操作代码
	* @param OPR_INFO.GROUP_ID	 工号归属
	* 
	* @param BUSI_INFO.PHONE_NO
	* @param BUSI_INFO.ID_NO
	* 
	* @return 
	* @throws Exception
	* @author guowy
	*/
	OutDTO init(final InDTO inParam);
	
	/**
	* 名称： 陈死账回收回退确认：用户缴费信息进行回退
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

	/**
	 * 名称： 陈死账回收回退取缴费记录
	 * @param OPR_INFO.
	 * @param OPR_INFO.
	 *
	 * @param BUSI_INFO
	 *
	 * @return
	 * @return OUT_DATA
	 *
	 * @throws Exception
	 * @author jiassa
	 */
	OutDTO getPaySnInfo(InDTO inParam);

}
