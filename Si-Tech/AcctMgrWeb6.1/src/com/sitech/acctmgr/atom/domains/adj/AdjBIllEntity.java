package com.sitech.acctmgr.atom.domains.adj;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class AdjBIllEntity {
	
	@JSONField(name="BILL_ID")
	@ParamDesc(path="BILL_ID",cons=ConsType.QUES,type="long",len="14",desc="账单流水",memo="略")
	protected long billId;	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账户号码",memo="略")
	protected long contractNo;
	public long getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(long phoneNo) {
		this.phoneNo = phoneNo;
	}
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="long",len="18",desc="用户号码",memo="略")
	protected long phoneNo;
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.QUES,type="long",len="18",desc="用户号码",memo="略")
	protected long idNo;	
	@JSONField(name="CUST_ID")
	@ParamDesc(path="CUST_ID",cons=ConsType.QUES,type="long",len="18",desc="客户ID",memo="略")
	protected long custId;	
	@JSONField(name="BRAND_ID")
	@ParamDesc(path="BRAND_ID",cons=ConsType.QUES,type="String",len="6",desc="用户品牌",memo="略")
	protected String brandId;	
	@JSONField(name="PROD_PRCID")
	@ParamDesc(path="PROD_PRCID",cons=ConsType.QUES,type="String",len="20",desc="产品资费标识",memo="略")
	protected String prodPrcid;	
	@JSONField(name="GROUP_ID")
	@ParamDesc(path="GROUP_ID",cons=ConsType.QUES,type="String",len="10",desc="用户归属",memo="略")
	protected String groupId;	
	@JSONField(name="NATURAL_MONTH")
	@ParamDesc(path="NATURAL_MONTH",cons=ConsType.QUES,type="int",len="6",desc="自然月标识",memo="略")
	protected int naturalMonth;	
	@JSONField(name="CYCLE_TYPE")
	@ParamDesc(path="CYCLE_TYPE",cons=ConsType.QUES,type="String",len="1",desc="帐期类型",memo="略")
	protected String cycleType;	
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.QUES,type="int",len="6",desc="帐期标识",memo="略")
	protected int billCycle;
	@JSONField(name="BILL_BEGIN")
	@ParamDesc(path="BILL_BEGIN",cons=ConsType.QUES,type="long",len="8",desc="账期开始日",memo="略")
	protected long billBegin;
	@JSONField(name="BILL_TYPE")
	@ParamDesc(path="BILL_TYPE",cons=ConsType.QUES,type="String",len="3",desc="账单类型",memo="略")
	protected String billType;	
	@JSONField(name="BILL_DAY")
	@ParamDesc(path="BILL_DAY",cons=ConsType.QUES,type="long",len="6",desc="出帐批次",memo="略")
	protected long billDay;
	@JSONField(name="ACCT_ITEM_CODE")
	@ParamDesc(path="ACCT_ITEM_CODE",cons=ConsType.QUES,type="String",len="10",desc="账目标识",memo="略")
	protected String acctItemCode;	
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.QUES,type="String",len="1",desc="状态",memo="略")
	protected String status;	
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.QUES,type="long",len="14",desc="应收额",memo="略")
	protected long shouldPay;
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.QUES,type="long",len="14",desc="优惠额",memo="略")
	protected long favourFee;
	@JSONField(name="PAYED_PREPAY")
	@ParamDesc(path="PAYED_PREPAY",cons=ConsType.QUES,type="long",len="14",desc="月结冲欠金额",memo="略")
	protected long payedPrepay;
	@JSONField(name="PAYED_LATER")
	@ParamDesc(path="PAYED_LATER",cons=ConsType.QUES,type="long",len="14",desc="缴费冲欠金额",memo="略")
	protected long payedLater;
	@JSONField(name="TIMES")
	@ParamDesc(path="TIMES",cons=ConsType.QUES,type="long",len="10",desc="通话次数",memo="略")
	protected long times;
	@JSONField(name="DURATION")
	@ParamDesc(path="DURATION",cons=ConsType.QUES,type="long",len="10",desc="通话时长",memo="略")
	protected long duration;
	@JSONField(name="BILL_END")
	@ParamDesc(path="BILL_END",cons=ConsType.QUES,type="long",len="8",desc="账期结束日",memo="略")
	protected long billEnd;
	@JSONField(name="TAX_RATE")
	@ParamDesc(path="TAX_RATE",cons=ConsType.QUES,type="double",len="8",desc="税率",memo="略")
	protected double taxRate;
	@JSONField(name="TAX_FEE")
	@ParamDesc(path="TAX_FEE",cons=ConsType.QUES,type="long",len="14",desc="应收税费",memo="略")
	protected long taxFee;
	@JSONField(name="PAYED_TAX")
	@ParamDesc(path="PAYED_TAX",cons=ConsType.QUES,type="long",len="14",desc="实收税费",memo="略")
	protected long payedTax;
	@JSONField(name="DETAIL_CODE")
	@ParamDesc(path="DETAIL_CODE",cons=ConsType.QUES,type="String",len="10",desc="账目项",memo="略")
	protected String detailCode;
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> toMap(){
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}
	
	
	/**
	 * @return the billId
	 */
	public long getBillId() {
		return billId;
	}
	/**
	 * @param billId the billId to set
	 */
	public void setBillId(long billId) {
		this.billId = billId;
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
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}
	/**
	 * @param custId the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}
	/**
	 * @return the brandId
	 */
	public String getBrandId() {
		return brandId;
	}
	/**
	 * @param brandId the brandId to set
	 */
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	/**
	 * @return the prodPrcid
	 */
	public String getProdPrcid() {
		return prodPrcid;
	}
	/**
	 * @param prodPrcid the prodPrcid to set
	 */
	public void setProdPrcid(String prodPrcid) {
		this.prodPrcid = prodPrcid;
	}
	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * @return the naturalMonth
	 */
	public int getNaturalMonth() {
		return naturalMonth;
	}
	/**
	 * @param naturalMonth the naturalMonth to set
	 */
	public void setNaturalMonth(int naturalMonth) {
		this.naturalMonth = naturalMonth;
	}
	/**
	 * @return the cycleType
	 */
	public String getCycleType() {
		return cycleType;
	}
	/**
	 * @param cycleType the cycleType to set
	 */
	public void setCycleType(String cycleType) {
		this.cycleType = cycleType;
	}
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
	 * @return the billBegin
	 */
	public long getBillBegin() {
		return billBegin;
	}
	/**
	 * @param billBegin the billBegin to set
	 */
	public void setBillBegin(long billBegin) {
		this.billBegin = billBegin;
	}
	/**
	 * @return the billType
	 */
	public String getBillType() {
		return billType;
	}
	/**
	 * @param billType the billType to set
	 */
	public void setBillType(String billType) {
		this.billType = billType;
	}
	/**
	 * @return the billDay
	 */
	public long getBillDay() {
		return billDay;
	}
	/**
	 * @param billDay the billDay to set
	 */
	public void setBillDay(long billDay) {
		this.billDay = billDay;
	}
	/**
	 * @return the acctItemCode
	 */
	public String getAcctItemCode() {
		return acctItemCode;
	}
	/**
	 * @param acctItemCode the acctItemCode to set
	 */
	public void setAcctItemCode(String acctItemCode) {
		this.acctItemCode = acctItemCode;
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
	 * @return the times
	 */
	public long getTimes() {
		return times;
	}
	/**
	 * @param times the times to set
	 */
	public void setTimes(long times) {
		this.times = times;
	}
	/**
	 * @return the duration
	 */
	public long getDuration() {
		return duration;
	}
	/**
	 * @param duration the duration to set
	 */
	public void setDuration(long duration) {
		this.duration = duration;
	}
	/**
	 * @return the billEnd
	 */
	public long getBillEnd() {
		return billEnd;
	}
	/**
	 * @param billEnd the billEnd to set
	 */
	public void setBillEnd(long billEnd) {
		this.billEnd = billEnd;
	}
	/**
	 * @return the taxRate
	 */
	public double getTaxRate() {
		return taxRate;
	}
	/**
	 * @param taxRate the taxRate to set
	 */
	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}
	/**
	 * @return the taxFee
	 */
	public long getTaxFee() {
		return taxFee;
	}
	/**
	 * @param taxFee the taxFee to set
	 */
	public void setTaxFee(long taxFee) {
		this.taxFee = taxFee;
	}
	/**
	 * @return the payedTax
	 */
	public long getPayedTax() {
		return payedTax;
	}
	/**
	 * @param payedTax the payedTax to set
	 */
	public void setPayedTax(long payedTax) {
		this.payedTax = payedTax;
	}
	/**
	 * @return the detailCode
	 */
	public String getDetailCode() {
		return detailCode;
	}
	/**
	 * @param detailCode the detailCode to set
	 */
	public void setDetailCode(String detailCode) {
		this.detailCode = detailCode;
	}

}
