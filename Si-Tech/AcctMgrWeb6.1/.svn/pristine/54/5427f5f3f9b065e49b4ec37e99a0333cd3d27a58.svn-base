package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeQryIsPayAndExpenseOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="IS_PAY",cons=ConsType.CT001,type="int",len="2",desc="是否缴费",memo="0：未缴过费，1：缴过费")
	private int isPay = 0;	
	@ParamDesc(path="IS_EXPENSE",cons=ConsType.CT001,type="int",len="2",desc="是否产生过消费",memo="0：未消费过， 1：消费过")
	private int isExpense = 0;
	@ParamDesc(path="REAL_PAY",cons=ConsType.CT001,type="long",len="20",desc="消费金额",memo="查询开户用户的消费金额")
	private long realPay = 0;
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="缴费金额",memo="除开户缴费后，其它缴费总金额")
	private long payFee = 0;
	
	@Override
	public MBean encode() {
		MBean mBean = new MBean();
		mBean.setRoot(getPathByProperName("isPay"), isPay);
		mBean.setRoot(getPathByProperName("isExpense"),isExpense);
		mBean.setRoot(getPathByProperName("realPay"), realPay);
		mBean.setRoot(getPathByProperName("payFee"), payFee);
		return mBean;
	}

	/**
	 * @return the isPay
	 */
	public int getIsPay() {
		return isPay;
	}

	/**
	 * @param isPay the isPay to set
	 */
	public void setIsPay(int isPay) {
		this.isPay = isPay;
	}

	/**
	 * @return the isExpense
	 */
	public int getIsExpense() {
		return isExpense;
	}

	/**
	 * @param isExpense the isExpense to set
	 */
	public void setIsExpense(int isExpense) {
		this.isExpense = isExpense;
	}

	/**
	 * @return the realPay
	 */
	public long getRealPay() {
		return realPay;
	}

	/**
	 * @param realPay the realPay to set
	 */
	public void setRealPay(long realPay) {
		this.realPay = realPay;
	}

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}
	
	
}
