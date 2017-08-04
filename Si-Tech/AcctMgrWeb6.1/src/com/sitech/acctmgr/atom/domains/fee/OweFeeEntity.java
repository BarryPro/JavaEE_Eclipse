package com.sitech.acctmgr.atom.domains.fee;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.io.Serializable;

/**
 *
 * <p>Title: 缴费类业务查询中涉及到欠费列表的展示  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class OweFeeEntity implements Serializable {
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;

	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="18",desc="用户标识",memo="略")
	private long idNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long contractNo;

	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="long",len="6",desc="账期",memo="略")
	private long billCycle;
	
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="14",desc="欠费金额",memo="单位：分")
	private long oweFee;
	
	@JSONField(name="DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="欠费滞纳金",memo="单位：分")
	private long delayFee;
	
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="14",desc="应收金额",memo="单位：分")
	private long shouldPay;
	
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="14",desc="优惠金额",memo="单位：分")
	private long favourFee;
	
	@JSONField(name="PAYED_FEE")
	@ParamDesc(path="PAYED_FEE",cons=ConsType.CT001,type="long",len="14",desc="已缴费金额",memo="单位：分")
	private long payedFee;

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(long billCycle) {
		this.billCycle = billCycle;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	public long getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	public long getFavourFee() {
		return favourFee;
	}

	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}

	public long getPayedFee() {
		return payedFee;
	}

	public void setPayedFee(long payedFee) {
		this.payedFee = payedFee;
	}

	@Override
	public String toString() {
		return "OweFeeEntity{" +
				"phoneNo='" + phoneNo + '\'' +
				", idNo=" + idNo +
				", contractNo=" + contractNo +
				", billCycle=" + billCycle +
				", oweFee=" + oweFee +
				", delayFee=" + delayFee +
				", shouldPay=" + shouldPay +
				", favourFee=" + favourFee +
				", payedFee=" + payedFee +
				'}';
	}
}
