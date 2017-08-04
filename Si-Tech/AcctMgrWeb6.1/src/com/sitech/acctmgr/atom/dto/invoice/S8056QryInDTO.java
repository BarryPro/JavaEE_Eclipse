package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8056QryInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PAY_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "缴费流水", memo = "略")
	private long paySn;

	@ParamDesc(path = "BUSI_INFO.TOTAL_DATE", cons = ConsType.CT001, type = "string", len = "20", desc = "缴费日期", memo = "YYYYMMDD")
	private int totalDate;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "账户号码", memo = "")
	private long contractNo;
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		paySn = Long.parseLong(arg0.getStr(getPathByProperName("paySn")));
		totalDate = Integer.parseInt(arg0.getStr(getPathByProperName("totalDate")));
		contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}


}
