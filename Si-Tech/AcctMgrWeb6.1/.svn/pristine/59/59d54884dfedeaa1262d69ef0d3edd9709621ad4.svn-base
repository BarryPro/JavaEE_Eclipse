package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8247SaleTaxInfoOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -1475850530776591181L;

	@JSONField(name = "KP_SERVER")
	@ParamDesc(path = "KP_SERVER", cons = ConsType.CT001, type = "string", len = "1", desc = "开票服务器", memo = "略")
	private String kpServer;

	@JSONField(name = "ACCEPT_SERVER")
	@ParamDesc(path = "ACCEPT_SERVER", cons = ConsType.CT001, type = "compx", len = "1", desc = "受理服务器", memo = "略")
	private String acceptSever;

	@JSONField(name = "ADDRESS_PHONE")
	@ParamDesc(path = "ADDRESS_PHONE", cons = ConsType.CT001, type = "compx", len = "1", desc = "地址和服务号", memo = "略")
	private String addressPhone;

	@JSONField(name = "SALE_NAME")
	@ParamDesc(path = "SALE_NAME", cons = ConsType.CT001, type = "compx", len = "1", desc = "名称", memo = "略")
	private String saleName;

	@JSONField(name = "BANK_INFO")
	@ParamDesc(path = "BANK_INFO", cons = ConsType.CT001, type = "compx", len = "1", desc = "开户行和开户号码", memo = "略")
	private String bankInfo;

	@JSONField(name = "TAX_PAYER_ID")
	@ParamDesc(path = "TAX_PAYER_ID", cons = ConsType.CT001, type = "compx", len = "1", desc = "销方纳税人识别号", memo = "略")
	private String taxPayerId;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("kpServer"), kpServer);
		result.setRoot(getPathByProperName("acceptSever"), acceptSever);
		result.setRoot(getPathByProperName("addressPhone"), addressPhone);
		result.setRoot(getPathByProperName("saleName"), saleName);
		result.setRoot(getPathByProperName("bankInfo"), bankInfo);
		result.setRoot(getPathByProperName("taxPayerId"), taxPayerId);
		return result;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public String getKpServer() {
		return kpServer;
	}

	public void setKpServer(String kpServer) {
		this.kpServer = kpServer;
	}

	public String getAcceptSever() {
		return acceptSever;
	}

	public void setAcceptSever(String acceptSever) {
		this.acceptSever = acceptSever;
	}

	public String getAddressPhone() {
		return addressPhone;
	}

	public void setAddressPhone(String addressPhone) {
		this.addressPhone = addressPhone;
	}

	public String getSaleName() {
		return saleName;
	}

	public void setSaleName(String saleName) {
		this.saleName = saleName;
	}

	public String getBankInfo() {
		return bankInfo;
	}

	public void setBankInfo(String bankInfo) {
		this.bankInfo = bankInfo;
	}

}
