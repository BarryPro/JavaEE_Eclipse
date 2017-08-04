package com.sitech.acctmgr.inter.volume;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2017/3/28.
 */
public interface IGrpVolume {
    /**
     * 集团行业流量数据同步接口
     * @param inParam
     * @return
     */
    OutDTO dataSyn(InDTO inParam);

}
