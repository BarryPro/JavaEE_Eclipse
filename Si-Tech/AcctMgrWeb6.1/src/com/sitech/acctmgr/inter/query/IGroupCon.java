package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IGroupCon {
	/**
	 * 功能：根据集团unit_id查询在网集团用户
	 * 
	 * @param inparam
	 * @return
	 */

	OutDTO queryOnLineCon(InDTO inparam);

	/**
	 * 功能：根据集团unit_id查询离网集团用户
	 * 
	 * @param inparam
	 * @return
	 */
	OutDTO queryOffLineCon(InDTO inparam);

	OutDTO query(InDTO inParam);
}
