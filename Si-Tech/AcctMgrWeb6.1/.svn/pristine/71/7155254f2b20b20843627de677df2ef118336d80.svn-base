package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.atom.domains.volume.VolumeBookInOutDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

@SuppressWarnings("serial")
public class VolumeBookInAndOutQueryOutDTO extends CommonOutDTO {
	@ParamDesc(path = "BUSI_INFO.QUERY_COUNT", cons = ConsType.CT001, type = "string", len = "4", desc = "返回账本个数", memo = "")
	private String queryCount;

	@ParamDesc(path = "BUSI_INFO.IN_OUT_DETAIL", cons = ConsType.CT001, type = "compx", len = "", desc = "流量帐本收支明细列表", memo = "")
	private List<VolumeBookInOutDetail> details;


	@Override
	public MBean encode() {
		MBean mbean = super.encode();
		mbean.setRoot(getPathByProperName("queryCount"), queryCount);
		mbean.setRoot(getPathByProperName("details"), details);

		return mbean;
	}

	public String getQueryCount() {
		return queryCount;
	}

	public void setQueryCount(String queryCount) {
		this.queryCount = queryCount;
	}

	public List<VolumeBookInOutDetail> getDetails() {
		return details;
	}

	public void setDetails(List<VolumeBookInOutDetail> details) {
		this.details = details;
	}
}
