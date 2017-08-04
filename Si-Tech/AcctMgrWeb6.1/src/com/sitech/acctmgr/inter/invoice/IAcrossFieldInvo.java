package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：一级BOSS月结发票打印与查询接口
 * 
 * @author liuhl_bj
 *
 */
public interface IAcrossFieldInvo {

	/**
	 * 名称：一级BOSS月结发票查询
	 * 
	 * @param inDto
	 * @return
	 */
	OutDTO qryInvo(InDTO inParam);

	/**
	 * 名称：一级BOSS月结发票打印
	 * 
	 * @param inDto
	 * @return
	 */
	OutDTO printCfm(InDTO inParam);
}
