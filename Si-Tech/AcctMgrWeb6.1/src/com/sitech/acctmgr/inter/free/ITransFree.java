package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/26.
 */
public interface ITransFree {
    /**
     * 功能：套餐内可转赠流量查询
     * 对应旧接口：bs_QueryGprsZY
     * 调用渠道：手机客户端，网上营业厅
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
