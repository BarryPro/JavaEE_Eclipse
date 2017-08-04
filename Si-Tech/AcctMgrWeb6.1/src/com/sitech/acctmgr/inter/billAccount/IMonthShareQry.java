package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IMonthShareQry {

	/**
	 * 名称：查询月租分摊
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	OutDTO queryMonthShare(InDTO inParam);

}
