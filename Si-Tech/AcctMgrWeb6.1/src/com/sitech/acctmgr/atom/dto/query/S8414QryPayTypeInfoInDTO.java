package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title:查询pay_type的信息，冲销信息，回收落地账目项信息入参DTO
 * </p>
 * <p>
 * Description: 查询pay_type的信息，冲销信息，回收落地账目项信息入参DTO
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
public class S8414QryPayTypeInfoInDTO extends CommonInDTO {

	private static final long serialVersionUID = -5961590252161851952L;

	@ParamDesc(path = "BUSI_INFO.PAY_TYPE", cons = ConsType.CT001, type = "String", len = "40", desc = "账本类型", memo = "略")
	protected String payType = "";

	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "int", len = "40", desc = "账本类型", memo = "略")
	private int pageNum;

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean) */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPayType(arg0.getStr(getPathByProperName("payType")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("pageNum")))) {
			pageNum = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageNum")));
		}
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

}