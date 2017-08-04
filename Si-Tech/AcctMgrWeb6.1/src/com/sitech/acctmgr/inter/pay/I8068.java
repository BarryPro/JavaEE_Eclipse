package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 空中充值账户缴费接口  </p>
 * <p>Description: 提供空中充值账户缴费查询的校验服务  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface I8068 {
	OutDTO init (InDTO inParam);
}
