package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

@SuppressWarnings("serial")
public class OutBillEntity implements Serializable{

	@JSONField(name="BILL_INFO")
	@ParamDesc(path="BILL_INFO",cons=ConsType.CT001,type="compx",len="1",desc="七大类展示",memo="略")
	StatusBillInfoEntity billInfo = null;
	
	@JSONField(name="DETAIL_LIST")
	@ParamDesc(path="DETAIL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="账单明细列表",memo="略")
	List<StatusBillInfoEntity> detailList = null;

	public StatusBillInfoEntity getBillInfo() {
		return billInfo;
	}

	public void setBillInfo(StatusBillInfoEntity billInfo) {
		this.billInfo = billInfo;
	}

	public List<StatusBillInfoEntity> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<StatusBillInfoEntity> detailList) {
		this.detailList = detailList;
	}
	
	
}

