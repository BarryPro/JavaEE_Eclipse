package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

import com.thoughtworks.xstream.annotations.XStreamAlias;

public class InvoiceXhfInfo {
	// 省份ID
	private String regionCode;

	// 销货方识别号
	private String xhfnsrsbh;

	// 销货方名称
	private String xhfmc;

	// 销货方地址
	private String xhfdz;

	// 销货方电话
	private String xhfdh;
	
	private String bankName;
	
	private String bankCode;

	private String mark;

	private String fhr;

	// 授权码
	private String sqm;

	// 销货方银行账号
	@XStreamAlias("XHF_YHZH")
	private String xhfyhzh;

	public String getXhfnsrsbh() {
		return xhfnsrsbh;
	}

	public void setXhfnsrsbh(String xhfnsrsbh) {
		this.xhfnsrsbh = xhfnsrsbh;
	}

	public String getXhfmc() {
		return xhfmc;
	}

	public void setXhfmc(String xhfmc) {
		this.xhfmc = xhfmc;
	}

	public String getXhfdz() {
		return xhfdz;
	}

	public void setXhfdz(String xhfdz) {
		this.xhfdz = xhfdz;
	}

	public String getXhfdh() {
		return xhfdh;
	}

	public void setXhfdh(String xhfdh) {
		this.xhfdh = xhfdh;
	}

	public String getXhfyhzh() {
		return xhfyhzh;
	}

	public void setXhfyhzh(String xhfyhzh) {
		this.xhfyhzh = xhfyhzh;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getFhr() {
		return fhr;
	}

	public void setFhr(String fhr) {
		this.fhr = fhr;
	}

	public String getSqm() {
		return sqm;
	}

	public void setSqm(String sqm) {
		this.sqm = sqm;
	}

}
