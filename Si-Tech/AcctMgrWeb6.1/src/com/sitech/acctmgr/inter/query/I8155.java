package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:  话费加油包查询接口 </p>
* <p>Description:  话费加油包查询接口 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface I8155 {

	OutDTO init(final InDTO inParam);
	
	OutDTO limitQry(final InDTO inParam);
	
	OutDTO ruleQry(final InDTO inParam);
	
	OutDTO transRule(final InDTO inParam);
}
