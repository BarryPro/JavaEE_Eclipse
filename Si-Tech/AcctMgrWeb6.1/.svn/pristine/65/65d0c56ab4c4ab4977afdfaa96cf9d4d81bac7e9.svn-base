package com.sitech.acctmgr.atom.dto.detail;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDetailRawQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 8838165671510924111L;

	@ParamDesc(path = "BASE_INFO", cons = ConsType.PLUS, len = "", type = "complex", desc = "基础信息", memo = "List<String>")
	private List<String> baseInfo;

	@ParamDesc(path = "DETAIL_INFO", cons = ConsType.PLUS, len = "", type = "complex", desc = "详单列表", memo = "List")
	private List<ChannelDetail> channelDetails = null;


	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("baseInfo"), baseInfo);
		result.setRoot(getPathByProperName("channelDetails"), channelDetails);

		return result; 
	}

	public List<String> getBaseInfo() {
		return baseInfo;
	}

	public void setBaseInfo(List<String> baseInfo) {
		this.baseInfo = baseInfo;
	}

	public List<ChannelDetail> getChannelDetails() {
		return channelDetails;
	}

	public void setChannelDetails(List<ChannelDetail> channelDetails) {
		this.channelDetails = channelDetails;
	}
}
