package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:5M短信升级或者多上多奖权限判断接口  </p>
* <p>Description: 5M短信升级权限判断接口 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface ISmsRightJudge {
	OutDTO query(final InDTO inParam);
	
	OutDTO isGprsCmd(final InDTO inParam);
}
