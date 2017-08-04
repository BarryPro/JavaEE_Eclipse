package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8107QryBillDetailInDTO extends CommonInDTO {
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户号码",memo="略")
	private long idNo = 0;
	@ParamDesc(path="BUSI_INFO.BILL_CYCLE",cons=ConsType.CT001,type="int",len="6",desc="查询帐期",memo="略")
	private int billCycle = 0;
	@ParamDesc(path="BUSI_INFO.STATUS",cons=ConsType.CT001,type="string",len ="1",desc="帐单状态",memo="2：已缴、0：未缴、3、呆坏账")
	private String status = "";
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		billCycle = Integer.parseInt(arg0.getStr(getPathByProperName("billCycle")));
		status = arg0.getStr(getPathByProperName("status"));
	}

	public long getContractNo() {
		return contractNo;
	}



	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}



	public long getIdNo() {
		return idNo;
	}



	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}



	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}	
}
