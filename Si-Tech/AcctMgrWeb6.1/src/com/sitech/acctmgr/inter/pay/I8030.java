package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * <p>Title: 托收缴费  </p>
 * <p>Description:  托收缴费查询、确认接口   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface I8030 {
	OutDTO getConNo(final InDTO inParam);
	OutDTO init(final InDTO inParam);
	OutDTO cfm(final InDTO inParam);
}
