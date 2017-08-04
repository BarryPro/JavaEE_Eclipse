package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPreInvoiceRecycleQryDetailInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "集团ID", memo = "略")
	private long unitId;

	@ParamDesc(path = "BUSI_INFO.PRINT_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "打印流水", memo = "略")
	private long printSn;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		unitId = ValueUtils.longValue(arg0.getStr(getPathByProperName("unitId")));
		printSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("printSn")));
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

}
