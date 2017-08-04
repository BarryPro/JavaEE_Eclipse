package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class InvNoOccupyEntity implements Serializable {

	@JSONField(name = "INVTYPE_NAME")
	@ParamDesc(path = "INVTYPE_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "发票类型名称", memo = "略")
	private String invTypeName;

	@JSONField(name = "INVTYPE_CODE")
	@ParamDesc(path = "INVTYPE_CODE", cons = ConsType.QUES, type = "String", len = "10", desc = "发票类型编码", memo = "略")
	private String invTypeCode;

	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.CT001, type = "String", len = "12", desc = "发票号码", memo = "略")
	private String invNo;

	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "12", desc = "发票代码", memo = "略")
	private String invCode;

	@JSONField(name = "TAXTYPE_CODE")
	@ParamDesc(path = "TAXTYPE_CODE", cons = ConsType.QUES, type = "String", len = "12", desc = "发票代码", memo = "略")
	private String taxTypeCode;

	@JSONField(name = "INV_FEE")
	@ParamDesc(path = "INV_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "发票费用", memo = "略")
	private long fee;

	@JSONField(name = "PRINT_XML")
	@ParamDesc(path = "PRINT_XML", cons = ConsType.CT001, type = "String", len = "5048", desc = "发票打印模板", memo = "略")
	private String xmlStr;

	public long getFee() {
		return fee;
	}

	public void setFee(long fee) {
		this.fee = fee;
	}

	/**
	 * @return the taxTypeCode
	 */
	public String getTaxTypeCode() {
		return taxTypeCode;
	}

	/**
	 * @param taxTypeCode
	 *            the taxTypeCode to set
	 */
	public void setTaxTypeCode(String taxTypeCode) {
		this.taxTypeCode = taxTypeCode;
	}

	/**
	 * @return the invTypeName
	 */
	public String getInvTypeName() {
		return invTypeName;
	}

	/**
	 * @param invTypeName
	 *            the invTypeName to set
	 */
	public void setInvTypeName(String invTypeName) {
		this.invTypeName = invTypeName;
	}

	/**
	 * @return the invTypeCode
	 */
	public String getInvTypeCode() {
		return invTypeCode;
	}

	/**
	 * @param invTypeCode
	 *            the invTypeCode to set
	 */
	public void setInvTypeCode(String invTypeCode) {
		this.invTypeCode = invTypeCode;
	}

	/**
	 * @return the invNo
	 */
	public String getInvNo() {
		return invNo;
	}

	/**
	 * @param invNo
	 *            the invNo to set
	 */
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	/**
	 * @return the invCode
	 */
	public String getInvCode() {
		return invCode;
	}

	/**
	 * @param invCode
	 *            the invCode to set
	 */
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getXmlStr() {
		return xmlStr;
	}

	public void setXmlStr(String xmlStr) {
		this.xmlStr = xmlStr;
	}

}
