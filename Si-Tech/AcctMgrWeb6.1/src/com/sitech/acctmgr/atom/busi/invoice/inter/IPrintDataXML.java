package com.sitech.acctmgr.atom.busi.invoice.inter;

import java.util.Map;

import com.sitech.acctmgr.atom.domains.invoice.InvoiceDispEntity;

/**
 *
 * <p>
 * Title: 对发票报文处理
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
 * @author fanck
 * @version 1.0
 */
public interface IPrintDataXML {

	/**
	 * 名称：获取发票打印xml
	 * 
	 * @param invoice
	 * @return
	 */
	String getPrintXml(InvoiceDispEntity invoice, int userFlag, String userType);

	/**
	 * 获取打印免填单的xml
	 * 
	 * @param inMap
	 * @return
	 */
	String getPrintXml(Map<String, Object> inMap);


}
