package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I8081Print {
	/**
	 * 退预存款（非实名）打印免填单
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO print(InDTO inParam);
}
