package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public interface I8247TaxInvo {



	/**
	 * 查询销货方纳税人的信息
	 * 
	 * @author liuhl_bj
	 * @param inParam
	 * @return
	 */
	OutDTO saleTaxInfo(InDTO inParam);

	/**
	 * 查询发票流程信息
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO invoiceFlowInfo(InDTO inParam);

	/**
	 * 开具发票，红字发票或者蓝字发票
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO report(InDTO inParam);

	/**
	 * 作废发票
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO disable(InDTO inParam);

	/**
	 * 打回
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO callback(InDTO inParam);

	/**
	 * 传递
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO trans(InDTO inParam);
}
