package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface ISPBillAcctRule {
	
	/**
	 * 功能：查询sp业务计费类型(CRM侧)
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);

}
