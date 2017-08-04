package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvoiceDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：8005发票打印出参
 * 
 * @author liuhl_bj
 *
 */
public class S8005PrintOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -7632155663233630019L;

	@JSONField(name = "PRINT_INFO")
	@ParamDesc(path = "PRINT_INFO", cons = ConsType.PLUS, type = "compx", len = "10", desc = "打印报文及详细信息", memo = "略")
	private InvNoOccupyEntity printInfo;

	@JSONField(name = "INV_INFO")
	@ParamDesc(path = "INV_INFO", cons = ConsType.PLUS, type = "compx", len = "10", desc = "打印报文及详细信息", memo = "略")
	private InvoiceDispEntity invDisp;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("printInfo"), printInfo);
		result.setRoot(getPathByProperName("invDisp"), invDisp);
		return result;
	}

	public InvNoOccupyEntity getPrintInfo() {
		return printInfo;
	}

	public void setPrintInfo(InvNoOccupyEntity printInfo) {
		this.printInfo = printInfo;
	}

	public InvoiceDispEntity getInvDisp() {
		return invDisp;
	}

	public void setInvDisp(InvoiceDispEntity invDisp) {
		this.invDisp = invDisp;
	}

}
