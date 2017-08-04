package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.StringUtil;

public class S8084GetBackBusiInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1841915498780718940L;
	
	@ParamDesc(path = "BUSI_INFO.DETAIL_TYPE", cons = ConsType.CT001, desc = "详单类型", len = "5", type = "string", memo = "默认为空，用于sp详单")
	private String detailType;

	public void decode(MBean arg0){
		super.decode(arg0);
		
		if (StringUtil.isNotEmptyOrNull(arg0.getStr(getPathByProperName("detailType")))) {
			detailType = arg0.getStr(getPathByProperName("detailType"));
		}
	}

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}

}
