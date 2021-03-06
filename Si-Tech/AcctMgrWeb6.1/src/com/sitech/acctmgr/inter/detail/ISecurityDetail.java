package com.sitech.acctmgr.inter.detail;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/11/10.
 */
public interface ISecurityDetail {
    /**
     * 功能：安保部详单信息查询
     * 对应老接口：s1510_detqry 安保信息查询(e234)
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
    
}
