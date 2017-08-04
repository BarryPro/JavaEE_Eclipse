package com.sitech.acctmgr.atom.busi.invoice.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;

/**
 * 名称：打印发票的业务实体
 * 
 * @author liuhl_bj
 *
 */
public interface IInvPrint {
	/**
	 * 名称：打印预存发票
	 * 
	 * @author liuhl
	 * @param inMap
	 * @return
	 */
	Map<String, Object> printPreInvoice(Map<String, Object> inMap);

	/**
	 * 名称：打印月结发票
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	List<InvNoOccupyEntity> printMonthInvoice(Map<String, Object> inParam);

	/**
	 * 名称：集团打印发票
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	InvNoOccupyEntity printGrpInvoice(Map<String, Object> inParam);

	/**
	 * 名称：集团预开发票打印
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	InvNoOccupyEntity printPreGrpInvoice(Map<String, Object> inParam);

	/**
	 * 功能：8068打印收据
	 * 
	 * @param inParam
	 * @return
	 */
	Map<String, Object> print8068Accept(Map<String, Object> inParam);

}
