package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
*
* <p>Title: 批量赠费接口  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author qiaolin
* @version 1.0
*/
public interface I8208 {


	/**
	 * 是否赠送： S赠送 C取消赠送
	 * @param inParam
	 * @return
     */
	OutDTO send(final InDTO inParam);


	/**
	 * 文件入库
	 * @param inParam
	 * @return
     */
	OutDTO cfm(final InDTO inParam);


	/**
	 * 授权审批
	 * @param inParam
	 * @return
     */
	OutDTO audit(final InDTO inParam);


	/**
	 * 审核人员文件导入批次记录查询（跨库）
	 * @param inParam
	 * @return
     */
	OutDTO auditQry(final InDTO inParam);

	
	/**
	 * 某一批次赠送明细
	 * @param inParam
	 * @return
     */
	OutDTO detail(final InDTO inParam);

	
	/**
	 * 某一批次赠送导出
	 * @param inParam
	 * @return
     */
	//OutDTO export(final InDTO inParam);
}
