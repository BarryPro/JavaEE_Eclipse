package com.sitech.acctmgr.atom.domains.detail;

import com.alibaba.fastjson.annotation.JSONField;

public class ElementAttribute {

	@JSONField(name = "ELEMENT_ID")
	private String elementId = "";
	@JSONField(name = "ELEMENT_NAME")
	private String elementName = "";
	@JSONField(name = "DEFAULT_VALUE")
	private String defaultValue = "";
	@JSONField(name = "ELEMENT_TYPE")
	private String elementType = "";
	@JSONField(name = "ELEMENT_TD_TYPE")
	private String elementTdType = ""; /*default:TD; when element is the thead label,* set the value "TH"*/
	@JSONField(name = "CONTROL_COLS")
	private String controlCols = "";
	@JSONField(name = "ATTR_STR")
	private String attrStr = "";
	@JSONField(name = "ELEMENT_TD_ATTR")
	private String elementTdAttr = "";

	public String getElementId() {
		return elementId;
	}

	public void setElementId(String elementId) {
		this.elementId = elementId;
	}

	public String getElementName() {
		return elementName;
	}

	public void setElementName(String elementName) {
		this.elementName = elementName;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getElementType() {
		return elementType;
	}

	public void setElementType(String elementType) {
		this.elementType = elementType;
	}

	public String getElementTdType() {
		return elementTdType;
	}

	public void setElementTdType(String elementTdType) {
		this.elementTdType = elementTdType;
	}

	public String getControlCols() {
		return controlCols;
	}

	public void setControlCols(String controlCols) {
		this.controlCols = controlCols;
	}

	public String getAttrStr() {
		return attrStr;
	}

	public void setAttrStr(String attrStr) {
		this.attrStr = attrStr;
	}

	public String getElementTdAttr() {
		return elementTdAttr;
	}

	public void setElementTdAttr(String elementTdAttr) {
		this.elementTdAttr = elementTdAttr;
	}

}
