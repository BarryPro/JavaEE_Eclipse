package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STransNoConversionInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1958067309131540659L;

	@ParamDesc(path="BUSI_INFO.IN_NO",cons=ConsType.CT001,type="String",len="40",desc="接入号码",memo="略")
	protected String inNo;
	@ParamDesc(path="BUSI_INFO.PAGE_FLAG",cons=ConsType.CT001,type="String",len="1",desc="页面标识",memo="0:8010补收页面调用；")
	protected String pageFlag;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setInNo(arg0.getStr(getPathByProperName("inNo")));
		setPageFlag(arg0.getStr(getPathByProperName("pageFlag")));
	}

	public String getInNo() {
		return inNo;
	}

	public void setInNo(String inNo) {
		this.inNo = inNo;
	}
	
	public String getPageFlag() {
		return pageFlag;
	}

	public void setPageFlag(String pageFlag) {
		this.pageFlag = pageFlag;
	}
	
	
}
