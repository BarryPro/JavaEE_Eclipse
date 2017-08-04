package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:支付类型查询接口  </p>
* <p>Description: 支付类型查询接口  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IPayTypeQry {
	OutDTO query(InDTO inParam);
	OutDTO judgePayType(InDTO inParam);
}
