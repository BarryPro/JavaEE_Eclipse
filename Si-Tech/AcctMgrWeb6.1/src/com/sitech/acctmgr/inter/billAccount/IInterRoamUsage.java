package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 国漫用户产品使用情况
 */
public interface IInterRoamUsage {	
	
	/**
	 * 功能：国漫用户产品使用情况查询
	 * 对应老系统：TlsPubSelBoss
	 */
	OutDTO query(InDTO inParam);
	
}
