package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I2315 {
	OutDTO query(InDTO inParam);
	
	OutDTO cfm(InDTO inParam);
}
