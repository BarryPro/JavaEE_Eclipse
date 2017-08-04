package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;


/**   
 * @Description: 托收帐户下用户按状态统计托收帐单数据实体
 * @author:  wangyla
 * @version:
 * @createTime:  2015-3-16 下午9:00:31
 */

public class CollOweStatusGroupEntity implements Serializable {

	private static final long serialVersionUID = 7006622064865321272L;
	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, len = "18", desc = "用户ID", type = "long", memo = "略")
	long idNo;
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", desc = "服务号码", type = "string", memo = "略")
	String phoneNo;
	@JSONField(name = "SHOULD_PAY")
	@ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "14", desc = "帐户下用户总应收", type = "long", memo = "略")
	long shouldPay;
	@JSONField(name = "FAVOUR_FEE")
	@ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "14", desc = "帐户下用户总优惠", type = "long", memo = "略")
	long favourFee;
	@JSONField(name = "PAYED_PREPAY")
	@ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, len = "14", desc = "帐户下用户总划拨", type = "long", memo = "略")
	long payedPrepay;
	@JSONField(name = "PAYED_LATER")
	@ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, len = "14", desc = "帐户下用户总冲销", type = "long", memo = "略")
	long payedLater;
	@JSONField(name = "STATUS_NAME")
	@ParamDesc(path = "STATUS_NAME", cons = ConsType.CT001, len = "20", desc = "帐单欠费状态", type = "string", memo = "略")
	String statusName;

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
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

	public long getPayedPrepay() {
		return payedPrepay;
	}

	public void setPayedPrepay(long payedPrepay) {
		this.payedPrepay = payedPrepay;
	}

	public long getPayedLater() {
		return payedLater;
	}

	public void setPayedLater(long payedLater) {
		this.payedLater = payedLater;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}	
}
