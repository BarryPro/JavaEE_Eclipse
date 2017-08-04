package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:包年费用查询接口  </p>
* <p>Description: 包年费用查询接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IPacketFeeQry {
	OutDTO query(final InDTO inParam);
}
