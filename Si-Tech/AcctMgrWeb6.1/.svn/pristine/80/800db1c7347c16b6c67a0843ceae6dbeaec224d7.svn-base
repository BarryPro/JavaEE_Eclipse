package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8081PrintOutDTO extends OutDTO {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "XML_STR")
	@ParamDesc(path = "XML_STR", cons = ConsType.CT001, type = "String", len = "100", desc = "xml", memo = "略")
	private String xmlStr;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("xmlStr"), this.xmlStr);
		return result;
	}

	public String getXmlStr() {
		return xmlStr;
	}

	public void setXmlStr(String xmlStr) {
		this.xmlStr = xmlStr;
	}
}
