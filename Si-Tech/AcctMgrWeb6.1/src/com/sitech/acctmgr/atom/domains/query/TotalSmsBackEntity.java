package com.sitech.acctmgr.atom.domains.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class TotalSmsBackEntity {
	
	@JSONField(name = "PAY_ALL")
	@ParamDesc(path="PAY_ALL",cons=ConsType.CT001,type="String",len="15",desc="总返费金额",memo="单位：分")
	protected long payAll;
	@JSONField(name = "BEGIN_TIME")
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="14",desc="返费开始时间",memo="略")
	protected String beginTime = "";
	
	@JSONField(name = "DETAIL_LIST")
	@ParamDesc(path="DETAIL_LIST",cons=ConsType.STAR,type="complex",len="1",desc="返费明细列表",memo="略")
	protected List<SmsBackPayEntity> detailList = new ArrayList<SmsBackPayEntity>();

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the detailList
	 */
	public List<SmsBackPayEntity> getDetailList() {
		return detailList;
	}

	/**
	 * @param detailList the detailList to set
	 */
	public void setDetailList(List<SmsBackPayEntity> detailList) {
		this.detailList = detailList;
	}

	/**
	 * @return the payAll
	 */
	public long getPayAll() {
		return payAll;
	}

	/**
	 * @param payAll the payAll to set
	 */
	public void setPayAll(long payAll) {
		this.payAll = payAll;
	}

}
