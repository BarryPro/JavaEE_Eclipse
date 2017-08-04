package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/7.
 */
public interface IBank {
    /**
	 * 功能：归属区县银行代码列表查询
	 * 
	 * @param inParam
	 * @return
	 */
    OutDTO query(InDTO inParam);

    /**
	 * 功能：归属地市托收银行列表查询
	 * 
	 * @param inParam
	 * @return
	 */
    OutDTO postQuery(InDTO inParam);

}
