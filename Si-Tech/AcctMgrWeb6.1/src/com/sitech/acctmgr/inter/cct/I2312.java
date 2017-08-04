package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I2312 {
	
	OutDTO query(final InDTO inParam);
	
	OutDTO cfm(InDTO inParam);
	
}
