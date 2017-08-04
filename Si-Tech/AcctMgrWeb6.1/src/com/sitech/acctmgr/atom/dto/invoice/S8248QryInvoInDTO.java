package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S8248QryInvoInDTO extends CommonInDTO {


	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "账户号", memo = "略")
	private String contractNo;

	@ParamDesc(path = "BUSI_INFO.BEGIN_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "开始年月", memo = "略")
	private int beginMon;

	@ParamDesc(path = "BUSI_INFO.END_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "结束年月", memo = "略")
	private int endMon;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, type = "int", len = "10", desc = "预开标志", memo = "0：开具正常发票    1：预开发票开具")
	private int flag = 0;


	// @ParamDesc(path = "BUSI_INFO.CUST_ID", cons = ConsType.CT001, type = "int", len = "10", desc = "结束年月", memo = "略")
	// private long custId;


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		contractNo = arg0.getStr(getPathByProperName("contractNo"));
		beginMon = Integer.parseInt(arg0.getStr(getPathByProperName("beginMon")));
		endMon = Integer.parseInt(arg0.getStr(getPathByProperName("endMon")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("flag")))) {
			flag = Integer.parseInt(arg0.getStr(getPathByProperName("flag")));
		}

	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public int getBeginMon() {
		return beginMon;
	}

	public void setBeginMon(int beginMon) {
		this.beginMon = beginMon;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public int getEndMon() {
		return endMon;
	}

	public void setEndMon(int endMon) {
		this.endMon = endMon;
	}

}
