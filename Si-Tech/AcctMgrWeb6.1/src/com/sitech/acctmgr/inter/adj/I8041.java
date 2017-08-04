package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 投诉退费  </p>
* <p>Description: 用户投诉扣费金额过多，或扣错费了，进行退费  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface I8041 {
	
	/**
	 * 查询SP_FLAG
	 * @param inParam
	 * @return
	 */
	OutDTO getSPFlag(InDTO inParam);
	/**
	* 名称： 投诉退费查询
	* 
	*/
	OutDTO init(InDTO inParam);
	
	/**
	* 名称： 投诉退费确认
	* 
	*/
	OutDTO cfm(InDTO inParam);
	
	/**
	 * 名称：sp信息查询
	 * 
	 * @param SPID: 企业代码
	 * @param SERVNAME：业务名词 可空
	 * 
	 * @return LIST_SP： SP明细 
	 * 		   LIST_SP.SPID: 企业代码 
	 *         LIST_SP.BIZCODE 业务代码
	 *         LIST_SP.SERVNAME 业务名称
	 *         
	 * @throws Exception
	 */
	OutDTO getSpList(InDTO inParam);
	
	/**
	 * 名称：投诉退费冲正查询服务
	 * 
	 * @param 
	 * @param 
	 * 
	 * @return 
	 *         
	 * @throws Exception
	 */
	OutDTO backInit(InDTO inParam);
	
	/**
	 * 名称：投诉退费冲正确认服务
	 * 
	 * @param 
	 * @param 
	 * 
	 * @return 
	 *         
	 * @throws Exception
	 */
	OutDTO backCfm(InDTO inParam);
	
	
	/**
	 * 名称：投诉退费信息查询
	 * 
	 * @param 
	 * @param 
	 * 
	 * @return 
	 *         
	 * @throws Exception
	 */
	OutDTO qryInfo(InDTO inParam);
	
	/**
	 * 名称：投诉退费批量查询
	 * 
	 * @param 
	 * @param 
	 * 
	 * @return 
	 *         
	 * @throws Exception
	 */
	OutDTO qryBatchInfo(InDTO inParam);
	
}
