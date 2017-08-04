package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/22.
 */
public interface I8102 {
    /**
     * 功能：查询用户一级帐目帐单及二级明细帐单，以关联的节点输出结果
     * @param inParam
     * @return
     */
    OutDTO queryBillDetail(InDTO inParam);
}
