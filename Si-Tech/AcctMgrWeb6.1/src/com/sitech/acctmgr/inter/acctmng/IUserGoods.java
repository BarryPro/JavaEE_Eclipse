package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 用户订购资费延期
 */
public interface IUserGoods {	
	
	/**
	 * 功能：用户订购资费延期数据同步 
	 * 表：UR_USERGOODS_ZFYQCHG
	 */
	OutDTO dataSyn(InDTO inParam);
	
}
