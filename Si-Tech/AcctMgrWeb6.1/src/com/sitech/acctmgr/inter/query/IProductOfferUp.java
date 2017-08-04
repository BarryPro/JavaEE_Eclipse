package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IProductOfferUp {
	
	/**
	 * 功能：产品资费升级操作
	 * @param inParam
	 * @return
	 */
	OutDTO operate(InDTO inParam);

}
