package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8010QueryGiveInfoInDTO extends CommonInDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3204970221223664549L;
	
	@ParamDesc(path="BUSI_INFO.CODE_VALUE",cons=ConsType.CT001,type="String",len="40",desc="送费类型代码",memo="略")
	protected String codeValue;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setCodeValue(arg0.getStr(getPathByProperName("codeValue")));
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8010";
		}
	}

	public String getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}
	
}
