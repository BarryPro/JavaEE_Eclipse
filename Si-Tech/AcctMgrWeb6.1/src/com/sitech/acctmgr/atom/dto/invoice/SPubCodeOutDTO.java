package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 指定月份账单出参DTO
 * </p>
 * <p>
 * Description: 对补收查询入参进行解析成MBean，并检验入参的正确性
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author LIJXD
 * @version 1.0
 */
public class SPubCodeOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8652188395619216012L;
	@JSONField(name = "LIST_ACCEPT")
	@ParamDesc(path = "LIST_ACCEPT", cons = ConsType.PLUS, type = "compx", len = "1", desc = "配置表集合", memo = "略")
	protected List<Map<String, Object>> listBackType;

	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result = new MBean();
		// MBean result=super.encode();
		result.setRoot(getPathByProperName("listBackType"), this.listBackType);
		// result.setBody("LIST_ACCEPT",listBackType);
		return result;
	}

	/**
	 * @return the listBackType
	 */
	public List<Map<String, Object>> getListBackType() {
		return listBackType;
	}

	/**
	 * @param listBackType
	 *            the listBackType to set
	 */
	public void setListBackType(List<Map<String, Object>> listBackType) {
		this.listBackType = listBackType;
	}

}
