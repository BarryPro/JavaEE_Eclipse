package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.bill.ItemRelEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询账目项配置出参DTO
 * </p>
 * <p>
 * Description: 查询账目项配置出参DTO，封装出参情况
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
public class S8414QryItemInfoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "ACCT_ITEM_LIST", cons = ConsType.CT001, type = "compx", len = "1", desc = "账目项配置信息", memo = "略")
	private ItemRelEntity acctItemList = null;

	@ParamDesc(path = "JSON_STRING", cons = ConsType.CT001, type = "string", len = "1", desc = "用于模糊查询", memo = "略")
	private String jsonString;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("acctItemList"), acctItemList);
		result.setRoot(getPathByProperName("jsonString"), jsonString);
		log.info(result.toString());
		return result;
	}

	public ItemRelEntity getAcctItemList() {
		return acctItemList;
	}

	public void setAcctItemList(ItemRelEntity acctItemList) {
		this.acctItemList = acctItemList;
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

}
