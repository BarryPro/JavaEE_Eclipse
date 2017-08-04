package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询账目项配置入参DTO
 * </p>
 * <p>
 * Description: 查询账目项配置入参DTO
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
public class S8414QryItemInfoInDTO extends CommonInDTO {

	private static final long serialVersionUID = -5961590252161851952L;

	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.CT001, type = "string", len = "1", desc = "查询类型", memo = "1:一级账目项，2：二级账目项，3：三级账目项")
	private String qryType;

	@ParamDesc(path = "BUSI_INFO.ITEM_CODE", cons = ConsType.CT001, type = "string", len = "1", desc = "账目项代码", memo = "略")
	private String itemCode;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setQryType(arg0.getStr(getPathByProperName("qryType")));
		setItemCode(arg0.getStr(getPathByProperName("itemCode")));
	}

	public String getQryType() {
		return qryType;
	}

	public void setQryType(String qryType) {
		this.qryType = qryType;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

}