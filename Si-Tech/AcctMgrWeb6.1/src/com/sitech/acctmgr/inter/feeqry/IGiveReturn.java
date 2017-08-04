package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:  赠送返还话费查询接口 </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author zhanggz
* @version 1.0
*/
public interface IGiveReturn {
	
	
	/** 
	* 名称：赠送返还话费查询
	* @param 
	* @return 
	* @
	 */
	OutDTO query(final InDTO inParam);
}
