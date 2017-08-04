package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：专款回收查询
 * 
 * @author liuhl
 *
 */
public interface I8413 {

	/**
	 * 名称：根据服务号码查询近三个月的专款回收信息
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);
}
