package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IBalanceOpen {
    /**
     * 能力开放平台余额查询接口
     * @param inParam
     * @return
     */
	OutDTO query(InDTO inDTO);
}
