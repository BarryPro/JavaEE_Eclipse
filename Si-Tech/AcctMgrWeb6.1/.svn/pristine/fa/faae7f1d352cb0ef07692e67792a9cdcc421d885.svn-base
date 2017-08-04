package com.sitech.acctmgr.atom.dto.volume;

import java.util.List;

import com.sitech.acctmgr.atom.domains.volume.VolumeBookDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookQueryOutDTO extends CommonOutDTO {
	@ParamDesc(path = "BUSI_INFO.QUERY_ALLVALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "总量信息", memo = "")
	private String queryAllValue;
	@ParamDesc(path = "BUSI_INFO.QUERY_COUNT", cons = ConsType.CT001, type = "string", len = "4", desc = "返回账本个数", memo = "")
	private String queryCount;

	@ParamDesc(path = "BUSI_INFO.BOOK_DETAIL", cons = ConsType.CT001, type = "compx", len = "", desc = "流量帐本明细列表", memo = "")
	private List<VolumeBookDetail> bookDetails;


	@Override
	public MBean encode() {
		MBean mbean = super.encode();
		mbean.setRoot(getPathByProperName("queryAllValue"), queryAllValue);
		mbean.setRoot(getPathByProperName("queryCount"), queryCount);
		mbean.setRoot(getPathByProperName("bookDetails"), bookDetails);

		return mbean;
	}

	public String getQueryAllValue() {
		return queryAllValue;
	}

	public void setQueryAllValue(String queryAllValue) {
		this.queryAllValue = queryAllValue;
	}

	public String getQueryCount() {
		return queryCount;
	}

	public void setQueryCount(String queryCount) {
		this.queryCount = queryCount;
	}

	public List<VolumeBookDetail> getBookDetails() {
		return bookDetails;
	}

	public void setBookDetails(List<VolumeBookDetail> bookDetails) {
		this.bookDetails = bookDetails;
	}
}
