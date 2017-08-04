package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 转账打印免填单
 * 
 * @author liuhl_bj
 *
 */
public interface I8014AcceptList {
	/**
	 * 转账打印免填单
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO print(InDTO inParam);
}
