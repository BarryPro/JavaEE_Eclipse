package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:统一门户查询接口  </p>
* <p>Description: 通过网厅、IVR等查询统一门户的账户余额、未出账话费等信息  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IUnifyPortalQry {
	OutDTO query(InDTO inParam);
}
