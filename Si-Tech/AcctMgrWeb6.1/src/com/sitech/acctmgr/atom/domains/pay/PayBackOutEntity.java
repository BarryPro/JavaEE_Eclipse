package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PayBackOutEntity implements Serializable {
	 
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="电话号码",memo="略")
	private String phoneNo;
	 
	@JSONField(name="PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="缴费金额",memo="略")
	private long payMoney;	 

	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="新增预存",memo="略")
	private long prepayFee;

	@JSONField(name="PAYED_OWE")
	@ParamDesc(path="PAYED_OWE",cons=ConsType.CT001,type="long",len="14",desc="冲销欠费",memo="略")
	private long payedOwe;

	@JSONField(name="DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="冲销滞纳金",memo="略")
	private long delayFee;
	
	@JSONField(name="PAY_NOTE")
	@ParamDesc(path="PAY_NOTE",cons=ConsType.CT001,type="String",len="100",desc="缴费备注",memo="略")
	private String payNote;

	
	
	/**
	 * @return the payNote
	 */
	public String getPayNote() {
		return payNote;
	}

	/**
	 * @param payNote the payNote to set
	 */
	public void setPayNote(String payNote) {
		this.payNote = payNote;
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
	 * @return the payedOwe
	 */
	public long getPayedOwe() {
		return payedOwe;
	}

	/**
	 * @param payedOwe the payedOwe to set
	 */
	public void setPayedOwe(long payedOwe) {
		this.payedOwe = payedOwe;
	}

	/**
	 * @return the delayFee
	 */
	public long getDelayFee() {
		return delayFee;
	}

	/**
	 * @param delayFee the delayFee to set
	 */
	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}
	
	 
}
