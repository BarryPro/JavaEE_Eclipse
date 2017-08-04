package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/12/15.
 */
public interface IGrpFree {
    /**
     * 功能：集团共享流量查询<br>
     * 注：对应 s210FavMsg
     * @param inParam
     * @return
     */
    OutDTO shareQuery(InDTO inParam);

    /**
     * 功能：个人用户查询集团共享流量
     * @param inParam
     * @return
     */
    OutDTO indivQuery(InDTO inParam);
}
