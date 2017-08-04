package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/8.
 */
public interface ICollectionConf {

    /**
     * 功能：查询工号归属区县范围内托收配置信息
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);
}
