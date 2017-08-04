package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/*
* <p>Title:  安保部详单查询录入接口 </p>
* <p>Description:  安保部详单查询录入接口 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface I8291 {
	OutDTO cfm(final InDTO inParam);

	/**
	 * 功能：安保详单录入用户信息查询
	 * @param inParam
	 * @return
     */
	OutDTO query(InDTO inParam);
}
