package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IPriceCode {

	/**
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);
	
}
