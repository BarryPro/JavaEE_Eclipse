package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:   一级BOSS查询余额接口</p>
* <p>Description:   查询余额，入表返回给一级boss</p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IOweIotQry {
	OutDTO query(InDTO inParam);
}
