package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

/**
 * 封装查询接口返回信息
 * 
 * @author wangxin
 *
 */

public class InvQryParam {

	private String fpqqlsh;

	private String ddh;

	private String fwm;

	private String ewm;

	private String fp_dm;

	private String fp_hm;

	private String kprq;

	private String kplx;

	private String hjbhsje;

	private String kphjse;

	private String pdf_file;

	private String pdf_url;

	private String returncode;

	private String returnmessage;

	public String getFpqqlsh() {
		return fpqqlsh;
	}

	public void setFpqqlsh(String fpqqlsh) {
		this.fpqqlsh = fpqqlsh;
	}

	public String getDdh() {
		return ddh;
	}

	public void setDdh(String ddh) {
		this.ddh = ddh;
	}

	public String getFwm() {
		return fwm;
	}

	public void setFwm(String fwm) {
		this.fwm = fwm;
	}

	public String getEwm() {
		return ewm;
	}

	public void setEwm(String ewm) {
		this.ewm = ewm;
	}

	public String getFp_dm() {
		return fp_dm;
	}

	public void setFp_dm(String fp_dm) {
		this.fp_dm = fp_dm;
	}

	public String getFp_hm() {
		return fp_hm;
	}

	public void setFp_hm(String fp_hm) {
		this.fp_hm = fp_hm;
	}

	public String getKprq() {
		return kprq;
	}

	public void setKprq(String kprq) {
		this.kprq = kprq;
	}

	public String getKplx() {
		return kplx;
	}

	public void setKplx(String kplx) {
		this.kplx = kplx;
	}

	public String getHjbhsje() {
		return hjbhsje;
	}

	public void setHjbhsje(String hjbhsje) {
		this.hjbhsje = hjbhsje;
	}

	public String getKphjse() {
		return kphjse;
	}

	public void setKphjse(String kphjse) {
		this.kphjse = kphjse;
	}

	public String getPdf_file() {
		return pdf_file;
	}

	public void setPdf_file(String pdf_file) {
		this.pdf_file = pdf_file;
	}

	public String getPdf_url() {
		return pdf_url;
	}

	public void setPdf_url(String pdf_url) {
		this.pdf_url = pdf_url;
	}

	public String getReturncode() {
		return returncode;
	}

	public void setReturncode(String returncode) {
		this.returncode = returncode;
	}

	public String getReturnmessage() {
		return returnmessage;
	}

	public void setReturnmessage(String returnmessage) {
		this.returnmessage = returnmessage;
	}

	@Override
	public String toString() {
		return "InvQryParam [fpqqlsh=" + fpqqlsh + ", ddh=" + ddh + ", fwm=" + fwm + ", ewm=" + ewm + ", fp_dm=" + fp_dm + ", fp_hm=" + fp_hm
				+ ", kprq=" + kprq + ", kplx=" + kplx + ", hjbhsje=" + hjbhsje + ", kphjse=" + kphjse + ", pdf_file=" + pdf_file + ", pdf_url="
				+ pdf_url + ", returncode=" + returncode + ", returnmessage=" + returnmessage + "]";
	}
}
