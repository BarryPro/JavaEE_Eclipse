package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamAsAttribute;

@XStreamAlias("REQUEST_FPKJXX")
public class InvoiceInfo {

	@XStreamAlias("class")
	@XStreamAsAttribute
	private String classalias = "REQUEST_FPKJXX";
	
	@XStreamAlias("FPKJXX_FPTXX")
	private InvoiceHeaderInfo invoiceHeader;
	
	@XStreamAlias("FPKJXX_XMXXS")
	private List<InvoiceDetailInfo> invoiceDetail = new ArrayList<>();

	@XStreamAlias("FPKJXX_DDXX")
	private InvoiceDdInfo invoiceDd;

	public String getClassalias() {
		return classalias;
	}

	public void setClassalias(String classalias) {
		this.classalias = classalias;
	}

	public InvoiceHeaderInfo getInvoiceHeader() {
		return invoiceHeader;
	}

	public void setInvoiceHeader(InvoiceHeaderInfo invoiceHeader) {
		this.invoiceHeader = invoiceHeader;
	}

	public List<InvoiceDetailInfo> getInvoiceDetail() {
		return invoiceDetail;
	}

	public void setInvoiceDetail(List<InvoiceDetailInfo> invoiceDetail) {
		this.invoiceDetail = invoiceDetail;
	}

	public InvoiceDdInfo getInvoiceDd() {
		return invoiceDd;
	}

	public void setInvoiceDd(InvoiceDdInfo invoiceDd) {
		this.invoiceDd = invoiceDd;
	}

}
