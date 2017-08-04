package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 集团红名单管理 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
*/
public interface I8258 {
	
	OutDTO query(final InDTO inParam);
	
	OutDTO cfm(final InDTO inParam);
	
	/*
	 * 免停信息查询
	 */
	OutDTO nonStopQry(final InDTO inParam);
}
