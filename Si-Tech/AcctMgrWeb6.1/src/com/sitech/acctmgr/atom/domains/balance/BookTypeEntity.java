package com.sitech.acctmgr.atom.domains.balance;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.WriteOffItemEntity;

public class BookTypeEntity {

	@JSONField(name = "PAY_TYPE")
	private String payType;

	@JSONField(name = "PAY_TYPE_NAME")
	private String payTypeName;

	@JSONField(name = "PAY_ATTR")
	private String payAttr;

	@JSONField(name = "PRIORITY")
	private String priority;

	@JSONField(name = "IS_TRANS")
	private String isTrans;

	@JSONField(name = "IS_REFUND")
	private String isRefund;

	@JSONField(name = "IS_SHOW")
	private String isShow;

	@JSONField(name = "WRITEOFF_ITEM_LIST")
	private List<WriteOffItemEntity> writeOffItemList;

	@JSONField(name = "RECYCLE_ITEM_CONF")
	private List<WriteOffItemEntity> recycleItemConf;

	@JSONField(name = "SUM")
	private int sum;

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayTypeName() {
		return payTypeName;
	}

	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	public String getPayAttr() {
		return payAttr;
	}

	public void setPayAttr(String payAttr) {
		this.payAttr = payAttr;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public List<WriteOffItemEntity> getWriteOffItemList() {
		return writeOffItemList;
	}

	public void setWriteOffItemList(List<WriteOffItemEntity> writeOffItemList) {
		this.writeOffItemList = writeOffItemList;
	}

	public List<WriteOffItemEntity> getRecycleItemConf() {
		return recycleItemConf;
	}

	public void setRecycleItemConf(List<WriteOffItemEntity> recycleItemConf) {
		this.recycleItemConf = recycleItemConf;
	}

	public String getIsTrans() {
		return isTrans;
	}

	public void setIsTrans(String isTrans) {
		this.isTrans = isTrans;
	}

	public String getIsRefund() {
		return isRefund;
	}

	public void setIsRefund(String isRefund) {
		this.isRefund = isRefund;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	@Override
	public String toString() {
		return "BookTypeEntity [payType=" + payType + ", payTypeName=" + payTypeName + ", payAttr=" + payAttr + ", priority=" + priority
				+ ", isTrans=" + isTrans + ", isRefund=" + isRefund + ", isShow=" + isShow + ", writeOffItemList=" + writeOffItemList
				+ ", recycleItemConf=" + recycleItemConf + "]";
	}

}
