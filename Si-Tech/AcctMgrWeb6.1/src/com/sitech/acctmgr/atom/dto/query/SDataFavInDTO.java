package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDataFavInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="1",desc="操作类型",memo="略")
	protected String opType = "";
	@ParamDesc(path="BUSI_INFO.SHOULD_PAY",cons=ConsType.QUES,type="long",len="201",desc="扣费金额",memo="略")
	protected long shouldPay = 0;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setOpType(arg0.getObject(getPathByProperName("opType")).toString());
		setShouldPay(Long.parseLong(arg0.getObject(getPathByProperName("shouldPay")).toString()));

	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}

	/**
	 * @return the shouldPay
	 */
	public long getShouldPay() {
		return shouldPay;
	}

	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}
	
}
