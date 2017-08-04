package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/22.
 */
public interface IBroadBill {
    /**
     * 功能：查询近6月宽带账户信息
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
