package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8225QryCollBillByPhoneInDTO extends CommonInDTO {

	private static final long serialVersionUID = 5197250555821000263L;
	
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "帐户号码", len = "18", type = "string", memo = "略")
	long contractNo = 0;
	@ParamDesc(path = "BUSI_INFO.BILL_CYCLE", cons = ConsType.CT001, desc = "查询帐期", len = "6", type = "string", memo = "略")
	int  billCycle = 0;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "手机号码", len = "40", type = "string", memo = "略")
	String phoneNo = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		billCycle = Integer.parseInt(arg0.getStr(getPathByProperName("billCycle")));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
}
