package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface I8084 {
	
	/**
	 * 查询退费业务种类
	 * @param inParam
	 * @return
	 */
	OutDTO getBackBusi(InDTO inParam);
	
	/**
	 * 查询用户SP业务
	 * @param inParam
	 * @return
	 */
	OutDTO listSPInfo(InDTO inParam);
	
	/**
	 * 一键退费确认服务处理
	 * @param inParam
	 * @return
	 */
	OutDTO cfm(InDTO inParam);

}
