package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:手机号查询归属省及归属地信息查询接口  </p>
* <p>Description: 根据手机号查询归属省及归属地信息 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IGetAreaCode {
	OutDTO query(final InDTO inParam);
}
