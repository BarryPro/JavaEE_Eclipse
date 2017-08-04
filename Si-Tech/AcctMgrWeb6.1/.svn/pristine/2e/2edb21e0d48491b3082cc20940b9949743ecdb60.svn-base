package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 账单展示信息实体
 * 
 *
 */

@SuppressWarnings("serial")
public class BillDisplayEntity implements Serializable {
	
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="int",len="6",desc="账期年月",memo="略")
	private int billCycle = 0;
	
	@JSONField(name="REAL_PAY")
	@ParamDesc(path="REAL_PAY",cons=ConsType.CT001,type="long",len="20",desc="消费",memo="略")
	private long realPay = 0;
	
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="20",desc="应缴费",memo="略")
	private long shouldPay = 0;
	
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="20",desc="优惠费",memo="略")
	private long favourFee = 0;
	
	@JSONField(name="PAYED_PREPAY")
	@ParamDesc(path="PAYED_PREPAY",cons=ConsType.CT001,type="long",len="20",desc="预存划拨",memo="略")
	private long payedPrepay = 0;
	
	@JSONField(name="PAYED_LATER")
	@ParamDesc(path="PAYED_LATER",cons=ConsType.CT001,type="long",len="20",desc="缴费冲销",memo="略")
	private long payedLater = 0;
	
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费",memo="略")
	private long oweFee = 0;
	
	@JSONField(name="DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="滞纳金",memo="略")
	private long delayFee = 0;
	
	@JSONField(name="BILL_BEGIN")
	@ParamDesc(path="BILL_BEGIN",cons=ConsType.CT001,type="int",len="10",desc="账期开始时间",memo="略")
	private int billBegin = 0;
	
	@JSONField(name="BILL_END")
	@ParamDesc(path="BILL_END",cons=ConsType.CT001,type="int",len="10",desc="账期结束时间",memo="略")
	private int billEnd = 0;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo = 0;
	
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="18",desc="用户ID",memo="略")
	private long idNo = 0;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.CT001,type="String",len="30",desc="状态名称",memo="略")
	private String status = "";
	
	@JSONField(name="STATUS_FLAG")
	@ParamDesc(path="STATUS_FLAG",cons=ConsType.CT001,type="String",len="1",desc="状态",memo="0：未缴  2：已缴")
	private String statusFlag = "";
	
	@JSONField(name = "ITEM_NAME")
	@ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, type = "String", len = "", desc = "账目项名称", memo = "")
	private String itemName;
	
	/**
	 * @return the billCycle
	 */
	public int getBillCycle() {
		return billCycle;
	}
	/**
	 * @param billCycle the billCycle to set
	 */
	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
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
	/**
	 * @return the favourFee
	 */
	public long getFavourFee() {
		return favourFee;
	}
	/**
	 * @param favourFee the favourFee to set
	 */
	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}
	/**
	 * @return the payedPrepay
	 */
	public long getPayedPrepay() {
		return payedPrepay;
	}
	/**
	 * @param payedPrepay the payedPrepay to set
	 */
	public void setPayedPrepay(long payedPrepay) {
		this.payedPrepay = payedPrepay;
	}
	/**
	 * @return the payedLater
	 */
	public long getPayedLater() {
		return payedLater;
	}
	/**
	 * @param payedLater the payedLater to set
	 */
	public void setPayedLater(long payedLater) {
		this.payedLater = payedLater;
	}
	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}
	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
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
	/**
	 * @return the billBegin
	 */
	public int getBillBegin() {
		return billBegin;
	}
	/**
	 * @param billBegin the billBegin to set
	 */
	public void setBillBegin(int billBegin) {
		this.billBegin = billBegin;
	}
	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}
	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}
	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}
	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusFlag() {
		return statusFlag;
	}
	public void setStatusFlag(String statusFlag) {
		this.statusFlag = statusFlag;
	}
	public int getBillEnd() {
		return billEnd;
	}
	public void setBillEnd(int billEnd) {
		this.billEnd = billEnd;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
}
