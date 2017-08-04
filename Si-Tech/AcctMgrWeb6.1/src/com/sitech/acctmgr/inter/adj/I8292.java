package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:  投诉退费原因维护  </p>
* <p>Description: 投诉退费原因维护相关服务接口  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface I8292 {
	
	/**
	* 名称： 退费原因查询
	* 
	*/
	OutDTO query(InDTO inParam);
	
	/**
	* 名称： 新增退费原因
	* 
	*/
	OutDTO add(InDTO inParam);
	
	/**
	 * 名称：退费原因删除
	 * 
	 */
	OutDTO del(InDTO inParam);
	
	/**
	 * 名称：退费原因列表查询
	 * 功能：一级退费原因列表查询、二级退费原因列表查询、三级退费原因列表chax
	 * 
	 *
	 */
	OutDTO getReasonInfo(InDTO inParam);

}
