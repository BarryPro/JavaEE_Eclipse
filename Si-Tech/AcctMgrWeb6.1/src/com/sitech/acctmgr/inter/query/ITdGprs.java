package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/22.
 */
public interface ITdGprs {
    /**
     * 功能：通过铁通网使用当月流量查询
     * 对应旧接口：sTDGprsQuery 用户当月通过TD网络产生的GPRS流量查询
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
