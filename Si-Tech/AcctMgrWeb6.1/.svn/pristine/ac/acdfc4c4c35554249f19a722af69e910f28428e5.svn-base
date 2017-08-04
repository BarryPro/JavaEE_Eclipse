package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.balance.BookTypeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询专款列表出参DTO
 * </p>
 * <p>
 * Description: 查询专款列表出参DTO，封装出参情况
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
public class S8414QryPayTypeOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "PAY_TYPE_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "专款类型列表", memo = "略")
	private List<BookTypeEntity> payTypeList = null;

	@ParamDesc(path = "JSON_STRING", cons = ConsType.QUES, type = "string", len = "10", desc = "用于模糊查询", memo = "略")
	private String JsonString;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("payTypeList"), payTypeList);
		result.setRoot(getPathByProperName("JsonString"), JsonString);
		log.info(result.toString());
		return result;
	}

	public List<BookTypeEntity> getPayTypeList() {
		return payTypeList;
	}

	public void setPayTypeList(List<BookTypeEntity> payTypeList) {
		this.payTypeList = payTypeList;
	}

	public String getJsonString() {
		return JsonString;
	}

	public void setJsonString(String jsonString) {
		JsonString = jsonString;
	}

}
