package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2017/6/5.
 */
public interface IPhoneBillOpen {

    /**
     * 能力开放平台用户月账单查询接口
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
