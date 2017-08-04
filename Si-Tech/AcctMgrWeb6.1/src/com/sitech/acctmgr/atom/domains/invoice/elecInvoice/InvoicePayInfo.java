package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamAsAttribute;

public class InvoicePayInfo {

	@XStreamAlias("class")
	@XStreamAsAttribute
	private String classalias;

	// 支付方式
	@XStreamAlias("ZFFS")
	private String zffs;

	// 支付流水号
	@XStreamAlias("ZFLSH")
	private String zflsh;

	// 支付平台
	@XStreamAlias("ZFPT")
	private String zfpt;

	public String getZffs() {
		return zffs;
	}

	public void setZffs(String zffs) {
		this.zffs = zffs;
	}

	public String getZflsh() {
		return zflsh;
	}

	public void setZflsh(String zflsh) {
		this.zflsh = zflsh;
	}

	public String getZfpt() {
		return zfpt;
	}

	public void setZfpt(String zfpt) {
		this.zfpt = zfpt;
	}

}
