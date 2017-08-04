package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/14.
 */
public interface IFavType {
    /**
     * 功能：用户优惠类型查询<br>
     * 调用渠道：短厅、IVR、wap、新业务微信平台
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
