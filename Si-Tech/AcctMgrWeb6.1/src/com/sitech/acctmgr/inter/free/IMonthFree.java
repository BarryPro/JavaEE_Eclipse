package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/22.
 */
public interface IMonthFree {
    /**
     * 功能：包月优惠信息查询<br>
     * 对应旧接口：sMonthFavQryWS 包月优惠查询<br>
     * 调用渠道：IVR，短信营业厅，WAP<br>
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
