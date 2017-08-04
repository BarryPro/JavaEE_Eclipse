package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface ITimeYearFree {
    /**
     * 功能：速拨时长包年优惠查询 <br>
     * 对应旧接口：sTimeYearQry <br>
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
