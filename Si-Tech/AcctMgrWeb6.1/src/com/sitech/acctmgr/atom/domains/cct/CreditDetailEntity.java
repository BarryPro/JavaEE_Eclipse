package com.sitech.acctmgr.atom.domains.cct;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

@SuppressWarnings("serial")
public class CreditDetailEntity implements Serializable {

	@JSONField(name = "CODE_TYPE")
	@ParamDesc(path="CODE_TYPE",cons=ConsType.CT001,type="String",len="10",desc="明细类型",memo="03：ARPU得分；02：网龄得分；04：双停得分")
	private String codeType = "";
	
	@JSONField(name = "CODE_NAME")
	@ParamDesc(path="CODE_NAME",cons=ConsType.CT001,type="String",len="100",desc="明细名称",memo="略")
	private String codeName = "";
	
	@JSONField(name = "CODE_VALUE")
	@ParamDesc(path="CODE_VALUE",cons=ConsType.CT001,type="String",len="10",desc="明细标识",memo="略")
	private String codeValue = "";
	
	@JSONField(name = "CODE_POINT")
	@ParamDesc(path="CODE_POINT",cons=ConsType.CT001,type="String",len="10",desc="信誉度金额",memo="略")
	private String codePoint = "";

	/**
	 * @return the codeType
	 */
	public String getCodeType() {
		return codeType;
	}

	/**
	 * @param codeType the codeType to set
	 */
	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	/**
	 * @return the codeName
	 */
	public String getCodeName() {
		return codeName;
	}

	/**
	 * @param codeName the codeName to set
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	/**
	 * @return the codeValue
	 */
	public String getCodeValue() {
		return codeValue;
	}

	/**
	 * @param codeValue the codeValue to set
	 */
	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	/**
	 * @return the codePoint
	 */
	public String getCodePoint() {
		return codePoint;
	}

	/**
	 * @param codePoint the codePoint to set
	 */
	public void setCodePoint(String codePoint) {
		this.codePoint = codePoint;
	}
	
	
	
}
