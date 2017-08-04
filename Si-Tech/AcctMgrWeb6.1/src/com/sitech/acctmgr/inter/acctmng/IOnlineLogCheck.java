package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IOnlineLogCheck {
    /**
     * 功能：用户上网日志校验
     */
	OutDTO check(InDTO inParam);
	
}
