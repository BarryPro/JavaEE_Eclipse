package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAcrossFieldQryInvoInDTO extends CommonInDTO {
	private static final long serialVersionUID = 7602758708860188716L;
	@ParamDesc(path = "BUSI_INFO.ID_TYPE", cons = ConsType.CT001, type = "String", len = "2", desc = "标识类型", memo = "01:手机号码")
	private String idType;

	@ParamDesc(path = "BUSI_INFO.ID_VALUE", cons = ConsType.CT001, type = "String", len = "20", desc = "标识号码", memo = "手机号码")
	private String idValue;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.QUES, type = "string", len = "6", desc = "起始日期", memo = "略")
	private int beginDate;

	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.QUES, type = "string", len = "6", desc = "终止日期", memo = "略")
	private int endDate;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		idType = arg0.getStr(getPathByProperName("idType"));
		idValue = arg0.getStr(getPathByProperName("idValue"));
		beginDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginDate")));
		endDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("endDate")));
	}

	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public String getIdValue() {
		return idValue;
	}

	public void setIdValue(String idValue) {
		this.idValue = idValue;
	}

	public int getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	public int getEndDate() {
		return endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

}
