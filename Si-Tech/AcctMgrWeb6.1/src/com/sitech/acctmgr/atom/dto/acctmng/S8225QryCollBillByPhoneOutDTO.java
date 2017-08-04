package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.collection.CollPhoneBillDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

public class S8225QryCollBillByPhoneOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -725610047543691911L;
	@JSONField(name="TOTAL_FEE")
	@ParamDesc( path = "TOTAL_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "托收帐单总费用", memo = "" )
	long totalFee = 0;
	@JSONField(name="TOTAL_FAVOUR")
	@ParamDesc( path = "TOTAL_FAVOUR", cons = ConsType.CT001, len = "", type = "long", desc = "托收帐单总优惠", memo = "" )
	long totalFavourFee = 0;
	@JSONField(name="BILL_LIST")
	@ParamDesc( path = "BILL_LIST", cons = ConsType.CT001, len = "", type = "complex", desc = "托收明细帐单", memo = "" )
	List<CollPhoneBillDetailEntity> billList = new ArrayList<CollPhoneBillDetailEntity>();
	
	@Override
	public MBean encode() {
		MBean mbean = new MBean();
		super.encode();
		mbean.setRoot(getPathByProperName("totalFee"), totalFee);
		mbean.setRoot(getPathByProperName("totalFavourFee"), totalFavourFee);
		mbean.setRoot(getPathByProperName("billList"), billList);
		return mbean;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public long getTotalFavourFee() {
		return totalFavourFee;
	}

	public void setTotalFavourFee(long totalFavourFee) {
		this.totalFavourFee = totalFavourFee;
	}

	public List<CollPhoneBillDetailEntity> getBillList() {
		return billList;
	}

	public void setBillList(List<CollPhoneBillDetailEntity> billList) {
		this.billList = billList;
	}

}
