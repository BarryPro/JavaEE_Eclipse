package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;

public class WriteOffItemEntity {

	@JSONField(name = "FIRST_ITEM_CODE")
	private String firstItemCode;

	@JSONField(name = "FIRST_ITEM_NAME")
	private String firstItemName;

	@JSONField(name = "SECOND_ITEM_CODE")
	private String secondItemCode;

	@JSONField(name = "SECOND_ITEM_NAME")
	private String secondItemName;

	@JSONField(name = "THIRD_ITEM_CODE")
	private String thirdItemCode;

	@JSONField(name = "THIRD_ITEM_NAME")
	private String thirdItemName;

	public String getFirstItemCode() {
		return firstItemCode;
	}

	public void setFirstItemCode(String firstItemCode) {
		this.firstItemCode = firstItemCode;
	}

	public String getFirstItemName() {
		return firstItemName;
	}

	public void setFirstItemName(String firstItemName) {
		this.firstItemName = firstItemName;
	}

	public String getSecondItemCode() {
		return secondItemCode;
	}

	public void setSecondItemCode(String secondItemCode) {
		this.secondItemCode = secondItemCode;
	}

	public String getSecondItemName() {
		return secondItemName;
	}

	public void setSecondItemName(String secondItemName) {
		this.secondItemName = secondItemName;
	}

	public String getThirdItemCode() {
		return thirdItemCode;
	}

	public void setThirdItemCode(String thirdItemCode) {
		this.thirdItemCode = thirdItemCode;
	}

	public String getThirdItemName() {
		return thirdItemName;
	}

	public void setThirdItemName(String thirdItemName) {
		this.thirdItemName = thirdItemName;
	}

	@Override
	public String toString() {
		return "WriteOffItemEntity [firstItemCode=" + firstItemCode + ", firstItemName=" + firstItemName + ", secondItemCode=" + secondItemCode
				+ ", secondItemName=" + secondItemName + ", thirdItemCode=" + thirdItemCode + ", thirdItemName=" + thirdItemName + "]";
	}

}
