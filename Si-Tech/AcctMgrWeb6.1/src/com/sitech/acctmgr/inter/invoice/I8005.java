package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I8005 {

	/**
	 * 名称：查询缴费记录
	 * 
	 * @param inParam
	 * @return
	 */
	public OutDTO qryPayInfo(InDTO inParam);

	/**
	 * 名称：发票打印
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	OutDTO print(InDTO inParam);
}
