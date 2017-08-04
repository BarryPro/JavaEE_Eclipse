package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2017/6/6.
 */
public interface IFreeOpen {
    /**
     * 能力开放平台套餐使用情况查询
     * @param inParam
     * @return
     */
    OutDTO query (InDTO inParam);

    /**
     * 能力开放平台流量使用情况查询
     * @param inParam
     * @return
     */
    OutDTO gprsQuery(InDTO inParam);
}
