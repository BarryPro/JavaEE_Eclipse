package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:查询代理商相关交易信息接口  </p>
* <p>Description: 查询代理商相关交易信息接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IAgentOprQry {
	
	/**
	*
	* <p>Description: 查询代理商当天、指定日期、指定号码的交易记录  </p>
	*/
	OutDTO query(InDTO inParam);
	
	/**
	*
	* <p>Description: 查询代理商当日或当月交易记录  </p>
	*/
	OutDTO queryDm(InDTO inParam);
}
