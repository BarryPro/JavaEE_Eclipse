package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/5.
 */
public interface ICollectionOrder {
    /**
	 * 功能：托收单查询
	 * 
	 * @param inParam
	 * @return
	 */
    OutDTO query(InDTO inParam);

}
