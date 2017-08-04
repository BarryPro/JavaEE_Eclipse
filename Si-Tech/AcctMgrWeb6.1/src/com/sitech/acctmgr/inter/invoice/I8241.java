package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 集团打印发票
 * 
 * @author liuhl_bj
 *
 */
public interface I8241 {
	/**
	 * 名称：查询集团打印预存发票信息
	 * 
	 * @author liuhl
	 * @param inDto
	 * @return
	 */
	OutDTO query(InDTO inDto);

	/**
	 * 名称：集团打印预存发票
	 * 
	 * @author liuhl
	 * @param inDto
	 * @return
	 */
	OutDTO print(InDTO inDto);
}
