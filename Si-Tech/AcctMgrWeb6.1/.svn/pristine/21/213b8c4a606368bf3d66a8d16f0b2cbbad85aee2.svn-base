package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.StringUtil;

public class SGetDetailTypeInDTO extends CommonInDTO{

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, desc = "查询类型", len = "5", type = "string", memo = "默认值为：25，用于安保详单")
	private String queryType = "25";
	@ParamDesc(path = "BUSI_INFO.DETAIL_TYPE", cons = ConsType.CT001, desc = "详单类型", len = "5", type = "string", memo = "默认为空，用于sp详单")
	private String detailType;

	public void decode(MBean arg0){
		super.decode(arg0);

		if (StringUtil.isNotEmptyOrNull(arg0.getStr(getPathByProperName("queryType")))) {
			queryType = arg0.getStr(getPathByProperName("queryType"));
		}

		if (StringUtil.isNotEmptyOrNull(arg0.getStr(getPathByProperName("detailType")))) {
			detailType = arg0.getStr(getPathByProperName("detailType"));
		}
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}
}
