package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IRefund {

	/**
	 * 名称：查询GPRS和梦网/自有业务投诉退费查询
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryRefundInfo(InDTO inParam);

	/**
	 * 名称：10086人工退费查询
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryRefundInfoFor10086(InDTO inParam);

}
