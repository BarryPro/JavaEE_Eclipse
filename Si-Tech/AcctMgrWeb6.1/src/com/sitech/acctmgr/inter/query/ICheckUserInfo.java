package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
*
* <p>Title:用户信息校验服务  </p>
* <p>Description: 用户信息校验服务接口  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author suzj
* @version 1.0
*/
public interface ICheckUserInfo {
	
	/**
	 * 名称：校验发票
	 * @param inParam
	 * @return
	 */
	OutDTO checkReceipt(InDTO inParam);
	
	/**
	 * 名称：校验sim卡号
	 * @param inParam
	 * @return
	 */
	OutDTO checkSim(InDTO inParam);
	
}
