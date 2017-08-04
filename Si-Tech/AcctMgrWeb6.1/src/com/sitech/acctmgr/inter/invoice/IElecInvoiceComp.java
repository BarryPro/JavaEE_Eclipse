package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：电子发票组合服务
 * 
 * @author
 *
 */
public interface IElecInvoiceComp {
	// apply to the department for electric invoice
	/**
	 * 名称：申请打印打印发票
	 * 
	 * @param inParam
	 * @return
	 */
	public OutDTO apply(InDTO inParam);

	/**
	 * 名称：查询未打印的发票
	 * 
	 * @param inParam
	 * @return
	 */
	public OutDTO queryUnprint(InDTO inParam);

	/**
	 * 名称：查询已打印的发票
	 * 
	 * @param inParam
	 * @return
	 */
	public OutDTO queryPrinted(InDTO inParam);

}
