package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface ICreditOpen {
    /**
     * 能力开放平台星级查询接口
     * @param inParam
     * @return
     */
	OutDTO query(final InDTO inParam);
}
