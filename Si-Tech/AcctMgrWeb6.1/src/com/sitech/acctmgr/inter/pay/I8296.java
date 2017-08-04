package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
* @Title:   []
* @Description: 
* @Date : 2016年8月12日下午5:06:44
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p> 	
*/
public interface I8296 {

	/**
	 * 查询集团账户划拨明细
	 * @param inParam
	 * @return
     */
	OutDTO initRecd(final InDTO inParam);
	
	/**
	 * 集团账户划拨到个人账户
	 * @param inParam
	 * @return
     */
	OutDTO cfm(final InDTO inParam);

	/**
	 * 删除划拨记录接口表
	 * @param inParam
	 * @return
     */
	OutDTO del(final InDTO inParam);
	

	
	/**
	 * 查询集团账户划拨成功记录
	 * @param inParam
	 * @return
     */
	OutDTO initHis(final InDTO inParam);
	
	/**
	 * 查询集团账户划拨失败记录
	 * @param inParam
	 * @return
     */
	OutDTO initErr(final InDTO inParam);
	
	
}
