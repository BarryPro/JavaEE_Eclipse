package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8224QryInvoInDTO extends CommonInDTO {

	private static final long serialVersionUID = 71876062480296217L;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账户号码", memo = "略")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "int", len = "20", desc = "开始年月", memo = "略")
	private int beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "int", len = "20", desc = "结束年月", memo = "略")
	private int endYm;


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		log.debug("月结发票查询的服务入参为：" + arg0);

		contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		beginYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginYm")));
		endYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("endYm")));
	}


	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getBeginYm() {
		return beginYm;
	}

	public void setBeginYm(int beginYm) {
		this.beginYm = beginYm;
	}

	public int getEndYm() {
		return endYm;
	}

	public void setEndYm(int endYm) {
		this.endYm = endYm;
	}

}
