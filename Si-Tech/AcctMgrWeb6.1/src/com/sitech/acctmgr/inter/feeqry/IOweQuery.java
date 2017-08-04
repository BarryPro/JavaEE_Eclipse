package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


public interface IOweQuery {
	/**
	 * 查询欠费信息，物理库中按照账期的欠费列表
	 * 
	 * @author liuhl_bj
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);
}
