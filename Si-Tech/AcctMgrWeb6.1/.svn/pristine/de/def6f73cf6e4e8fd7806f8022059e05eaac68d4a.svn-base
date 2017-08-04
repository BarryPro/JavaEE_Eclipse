package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S8248QryOnePayInvoInDTO extends CommonInDTO {


	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "账户号", memo = "略")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.BEGIN_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "开始年月", memo = "略")
	private int beginMon;

	@ParamDesc(path = "BUSI_INFO.END_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "结束年月", memo = "略")
	private int endMon;


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		beginMon = Integer.parseInt(arg0.getStr(getPathByProperName("beginMon")));
		endMon = Integer.parseInt(arg0.getStr(getPathByProperName("endMon")));
	}



	public int getBeginMon() {
		return beginMon;
	}

	public void setBeginMon(int beginMon) {
		this.beginMon = beginMon;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	public int getEndMon() {
		return endMon;
	}

	public void setEndMon(int endMon) {
		this.endMon = endMon;
	}

}
