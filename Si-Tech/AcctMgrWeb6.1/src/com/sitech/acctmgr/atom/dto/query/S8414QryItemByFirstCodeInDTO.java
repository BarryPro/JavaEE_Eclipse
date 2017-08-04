package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 根据一级账目项查询二级账目项入参DTO
 * </p>
 * <p>
 * Description: 根据一级账目项查询二级账目项入参DTO
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl_bj
 * @version 1.0
 */
public class S8414QryItemByFirstCodeInDTO extends CommonInDTO {

	private static final long serialVersionUID = -5961590252161851952L;

	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "string", len = "1", desc = "页数", memo = "")
	private String pageNum;

	@ParamDesc(path = "BUSI_INFO.ITEM_CODE", cons = ConsType.CT001, type = "string", len = "1", desc = "账目项代码", memo = "略")
	private String itemCode;

	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, type = "string", len = "1", desc = "查询类型", memo = "略")
	private String queryType;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPageNum(arg0.getStr(getPathByProperName("pageNum")));
		setItemCode(arg0.getStr(getPathByProperName("itemCode")));
		setQueryType(arg0.getStr(getPathByProperName("queryType")));
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

}