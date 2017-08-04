package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248QryInvoiceFeeInDTO extends CommonInDTO {

	private static final long serialVersionUID = 4654724435095489897L;

	@ParamDesc(path = "BUSI_INFO.PRINT_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "打印流水", memo = "")
	private long printSn;

	@ParamDesc(path = "BUSI_INFO.TAX_PAYER_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "纳税人识别号", memo = "")
	private String taxPayerId;


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		printSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("printSn")));
		taxPayerId = arg0.getStr(getPathByProperName("taxPayerId"));
	}


	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}


}
