package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class STopPayPrtQryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "S_RETURN_MSG", desc = "返回名称", cons = ConsType.CT001, type = "string", len = "20", memo = "0：未打印   1：已打印")
	private String sreturnmsg;

	@ParamDesc(path = "S_RETURN_CODE", desc = "返回代码", cons = ConsType.CT001, type = "string", len = "20", memo = "")
	private String sreturncode;

	@ParamDesc(path = "HOME_PROV", desc = "归属省份", cons = ConsType.CT001, type = "string", len = "20", memo = "")
	private String homeProv;

	@ParamDesc(path = "INVOICE_TYPE", desc = "发票标识", cons = ConsType.CT001, type = "string", len = "20", memo = "")
	private String invoiceType;

	@ParamDesc(path = "ACCT_DATE", desc = "发票日期", cons = ConsType.CT001, type = "string", len = "20", memo = "")
	private String acctDate;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("sreturnmsg"), sreturnmsg);
		result.setRoot(getPathByProperName("sreturncode"), sreturncode);
		result.setRoot(getPathByProperName("homeProv"), homeProv);
		result.setRoot(getPathByProperName("invoiceType"), invoiceType);
		result.setRoot(getPathByProperName("acctDate"), acctDate);
		result.setBody("RETURN_CODE", sreturncode);
		result.setBody("RETURN_MSG", sreturnmsg);
		return result;
	}

	public String getSreturnmsg() {
		return sreturnmsg;
	}

	public void setSreturnmsg(String sreturnmsg) {
		this.sreturnmsg = sreturnmsg;
	}

	public String getSreturncode() {
		return sreturncode;
	}

	public void setSreturncode(String sreturncode) {
		this.sreturncode = sreturncode;
	}

	public String getHomeProv() {
		return homeProv;
	}

	public void setHomeProv(String homeProv) {
		this.homeProv = homeProv;
	}

	public String getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
	}

	public String getAcctDate() {
		return acctDate;
	}

	public void setAcctDate(String acctDate) {
		this.acctDate = acctDate;
	}

}
