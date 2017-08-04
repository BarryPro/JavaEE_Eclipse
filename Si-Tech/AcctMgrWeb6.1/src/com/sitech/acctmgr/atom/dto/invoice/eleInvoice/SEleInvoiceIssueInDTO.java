package com.sitech.acctmgr.atom.dto.invoice.eleInvoice;
 
import java.util.List;

import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceDetailInfo;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class SEleInvoiceIssueInDTO extends CommonInDTO {

    
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.CUST_NAME", cons = ConsType.CT001, type = "string", len = "", desc = "客户名称", memo = "略")
	private String custName;

	@ParamDesc(path = "BUSI_INFO.LOGIN_NAME", cons = ConsType.CT001, type = "string", len = "", desc = "工号名称", memo = "略")
	private String loginName;

	@ParamDesc(path = "BUSI_INFO.INVOICEXM_INFO", cons = ConsType.CT001, type = "comp", len = "", desc = "项目信息", memo = "略")
	private List<InvoiceDetailInfo> invoiceXmInfo;

	@ParamDesc(path = "BUSI_INFO.CHN_SOURCE", cons = ConsType.CT001, type = "comp", len = "", desc = "渠道类型", memo = "略")
	private String chnSource;

	@ParamDesc(path = "BUSI_INFO.ORDER_ID", cons = ConsType.CT001, type = "comp", len = "", desc = "订单行号", memo = "略")
	private String orderId;
    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		custName = arg0.getStr(getPathByProperName("custName"));
		loginName = arg0.getStr(getPathByProperName("loginName"));
		invoiceXmInfo = arg0.getList(getPathByProperName("invoiceXmInfo"), InvoiceDetailInfo.class);
		chnSource = arg0.getStr(getPathByProperName("chnSource"));
		orderId = arg0.getStr(getPathByProperName("orderId"));

    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public List<InvoiceDetailInfo> getInvoiceXmInfo() {
		return invoiceXmInfo;
	}

	public void setInvoiceXmInfo(List<InvoiceDetailInfo> invoiceXmInfo) {
		this.invoiceXmInfo = invoiceXmInfo;
	}

	public String getChnSource() {
		return chnSource;
	}

	public void setChnSource(String chnSource) {
		this.chnSource = chnSource;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

}
