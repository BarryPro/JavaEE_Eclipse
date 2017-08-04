package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class WPrePayCardCfmInDTO extends CommonInDTO{

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5147202742997893915L;
	
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String inPhoneNo;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="40",desc="账号",memo="略")
	private long contractNo;
	@ParamDesc(path="BUSI_INFO.PAY_FEE",cons=ConsType.CT001,type="double",len="100",desc="付费金额",memo="略")
	private double payFee;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="100",desc="",memo="备注")
	private String remark;

	@Override
	public void decode(MBean arg0){
		super.decode(arg0);

		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setPayFee(Double.parseDouble(arg0.getObject(getPathByProperName("payFee")).toString()));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setRemark(arg0.getStr(getPathByProperName("remark")));
	}

	public String getInPhoneNo() {
		return inPhoneNo;
	}

	public void setInPhoneNo(String inPhoneNo) {
		this.inPhoneNo = inPhoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public double getPayFee() {
		return payFee;
	}

	public void setPayFee(double payFee) {
		this.payFee = payFee;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
