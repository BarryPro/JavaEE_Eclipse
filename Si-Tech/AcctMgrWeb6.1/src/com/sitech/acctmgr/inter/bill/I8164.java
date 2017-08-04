package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/29.
 */
public interface I8164 {
    /**
     * 功能：用户帐单打印查询 <br>
     *     支持普通用户、物联网用户和宽带用户
     * @param inParam
     * @return
     */
    OutDTO queryBill(InDTO inParam);
}
