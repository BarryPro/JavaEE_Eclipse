package com.sitech.acctmgr.atom.domains.pay;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title: 签约关系属性实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class FieldEntity {
	
	@JSONField(name = "FIELD_CODE")
	@ParamDesc(path="FIELD_CODE",cons=ConsType.CT001,type="String",len="8",desc="属性编号",memo="略")
	String fieldCode;
	
	@JSONField(name = "FIELD_VALUE")
	@ParamDesc(path="FIELD_VALUE",cons=ConsType.CT001,type="String",len="255",desc="该属性的值",memo="略")
	String fieldValue;
	
	@JSONField(name = "OTHER_VALUE")
	@ParamDesc(path="OTHER_VALUE",cons=ConsType.QUES,type="String",len="255",desc="该属性其他值，可以为空",memo="略")
	String otherValue;
	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "UserSignFieldEntity [fieldCode=" + fieldCode + ", fieldValue=" + fieldValue + ", otherValue=" + otherValue + "]";
	}

	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	public String getFieldCode() {
		return fieldCode;
	}

	public void setFieldCode(String fieldCode) {
		this.fieldCode = fieldCode;
	}

	public String getFieldValue() {
		return fieldValue;
	}

	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}

	public String getOtherValue() {
		return otherValue;
	}

	public void setOtherValue(String otherValue) {
		this.otherValue = otherValue;
	}

}
