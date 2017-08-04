package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SRemainFeeInitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2524717556835808608L;
	
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="15",desc="余额",memo="单位：分")
	protected long prepayFee ;
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="15",desc="手机号码",memo="略")
	protected String phoneNo ;
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="20",desc="操作流水",memo="略")
	protected long loginAccept ;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);

		return result;
	}

	/**
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}

	/**
	 * @param prepayFee the prepayFee to set
	 */
	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
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
	 * @return the loginAccept
	 */
	public long getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}
}
