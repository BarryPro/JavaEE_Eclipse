package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:扣费提醒接口  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IChargeFee {
	
	/**
	* <p>Title:扣费提醒开通关闭查询  </p>
	*/
	OutDTO query(final InDTO inParam);
	
	/**
	* <p>Title:扣费提醒开通关闭  </p>
	*/
	OutDTO cfm(final InDTO inParam);
	
	/**
	* <p>Title:扣费提醒更新  </p>
	*/
	OutDTO uTellCodeA(final InDTO inParam);
	
	/**
	* <p>Title:扣费提醒服务B类  </p>
	*/
	OutDTO uTellCodeB(final InDTO inParam);
}
