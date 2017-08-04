package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 手工系统充值查询  </p>
 * <p>Description:  </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface I2311 {

	OutDTO cfm(final InDTO inParam);
	
	OutDTO detail(final InDTO inParam);
}
