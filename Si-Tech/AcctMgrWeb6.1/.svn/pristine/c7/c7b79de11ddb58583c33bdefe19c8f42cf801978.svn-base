package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAgentOprDmOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -95059505640662864L;
	
	@ParamDesc(path="PAY_SUM",cons=ConsType.CT001,type="long",len="10",desc="缴费笔数",memo="略")
	private long paySum;
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="20",desc="缴费金额",memo="单位：分")
	private long payMoney;
	@ParamDesc(path="UNPAY_SUM",cons=ConsType.CT001,type="long",len="10",desc="冲正笔数",memo="略")
	private long unPaySum;
	@ParamDesc(path="UNPAY_MONEY",cons=ConsType.CT001,type="long",len="20",desc="冲正金额",memo="单位：分")
	private long unPayMoney;
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="账户金额",memo="单位：分")
	private long prepayFee;
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="18",desc="操作流水",memo="略")
	private String loginAccept;
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("paySum"), paySum);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("unPaySum"), unPaySum);
		result.setRoot(getPathByProperName("unPayMoney"), unPayMoney);
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);

		return result;
	}

	/**
	 * @return the paySum
	 */
	public long getPaySum() {
		return paySum;
	}

	/**
	 * @param paySum the paySum to set
	 */
	public void setPaySum(long paySum) {
		this.paySum = paySum;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the unPaySum
	 */
	public long getUnPaySum() {
		return unPaySum;
	}

	/**
	 * @param unPaySum the unPaySum to set
	 */
	public void setUnPaySum(long unPaySum) {
		this.unPaySum = unPaySum;
	}

	/**
	 * @return the unPayMoney
	 */
	public long getUnPayMoney() {
		return unPayMoney;
	}

	/**
	 * @param unPayMoney the unPayMoney to set
	 */
	public void setUnPayMoney(long unPayMoney) {
		this.unPayMoney = unPayMoney;
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
	 * @return the loginAccept
	 */
	public String getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}
	
}
