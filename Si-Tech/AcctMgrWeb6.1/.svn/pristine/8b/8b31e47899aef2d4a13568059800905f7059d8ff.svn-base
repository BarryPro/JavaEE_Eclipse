package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.TransFreeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/26.
 */
public class STransFreeQueryOutDTO extends CommonOutDTO {

	/*国内的参数*/
	@JSONField(name = "NATION_GPRS_TOTAL")
	@ParamDesc(path = "NATION_GPRS_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "应优惠可转赠流量(国内流量)", memo = "单位：MB")
	private String nationGprsTotal;

	@JSONField(name = "NATION_GPRS_USED")
	@ParamDesc(path = "NATION_GPRS_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "已使用可转赠流量(国内流量)", memo = "单位：MB")
	private String nationGprsUsed;

	@JSONField(name = "NATION_GPRS_REMAIN")
	@ParamDesc(path = "NATION_GPRS_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "剩余可转赠流量(国内流量)", memo = "单位：MB")
	private String nationGprsRemain;

	//（国内）可转赠明细列表
	@JSONField(name = "NATION_FREE_INFO")
	@ParamDesc(path = "NATION_FREE_INFO", cons = ConsType.CT001, len = "14", type = "String", desc = "剩余可转赠流量明细(国内流量)", memo = "单位：MB")
	private List<TransFreeEntity> nationFreeList;

	//省内的参数
	@JSONField(name = "PROV_GPRS_TOTAL")
	@ParamDesc(path = "PROV_GPRS_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "应优惠可转赠流量(省内流量)", memo = "单位：MB")
	private String provGprsTotal;

	@JSONField(name = "PROV_GPRS_USED")
	@ParamDesc(path = "PROV_GPRS_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "已使用可转赠流量(省内流量)", memo = "单位：MB")
	private String provGprsUsed;

	@JSONField(name = "PROV_GPRS_REMAIN")
	@ParamDesc(path = "PROV_GPRS_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "剩余可转赠流量(省内流量)", memo = "单位：MB")
	private String provGprsRemain;

	@JSONField(name = "PROV_FREE_INFO")
	@ParamDesc(path = "PROV_FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "剩余可转赠流量明细(省内流量)", memo = "单位：MB")
	private List<TransFreeEntity> provFreeList;

	@JSONField(name = "FREE_INFO")
	@ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "剩余优惠信息明细", memo = "list")
	private List<TransFreeEntity> freeList;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("freeList"), freeList);
		result.setRoot(getPathByProperName("nationGprsTotal"), nationGprsTotal);
		result.setRoot(getPathByProperName("nationGprsUsed"), nationGprsUsed);
		result.setRoot(getPathByProperName("nationGprsRemain"), nationGprsRemain);
		result.setRoot(getPathByProperName("nationFreeList"), nationFreeList);
		result.setRoot(getPathByProperName("provGprsTotal"), provGprsTotal);
		result.setRoot(getPathByProperName("provGprsUsed"), provGprsUsed);
		result.setRoot(getPathByProperName("provGprsRemain"), provGprsRemain);
		result.setRoot(getPathByProperName("provFreeList"), provFreeList);
		result.setRoot(getPathByProperName("freeList"), freeList);
		return result;
	}

	public String getNationGprsTotal() {
		return nationGprsTotal;
	}

	public void setNationGprsTotal(String nationGprsTotal) {
		this.nationGprsTotal = nationGprsTotal;
	}

	public String getNationGprsUsed() {
		return nationGprsUsed;
	}

	public void setNationGprsUsed(String nationGprsUsed) {
		this.nationGprsUsed = nationGprsUsed;
	}

	public String getNationGprsRemain() {
		return nationGprsRemain;
	}

	public void setNationGprsRemain(String nationGprsRemain) {
		this.nationGprsRemain = nationGprsRemain;
	}

	public List<TransFreeEntity> getNationFreeList() {
		return nationFreeList;
	}

	public void setNationFreeList(List<TransFreeEntity> nationFreeList) {
		this.nationFreeList = nationFreeList;
	}

	public String getProvGprsTotal() {
		return provGprsTotal;
	}

	public void setProvGprsTotal(String provGprsTotal) {
		this.provGprsTotal = provGprsTotal;
	}

	public String getProvGprsUsed() {
		return provGprsUsed;
	}

	public void setProvGprsUsed(String provGprsUsed) {
		this.provGprsUsed = provGprsUsed;
	}

	public String getProvGprsRemain() {
		return provGprsRemain;
	}

	public void setProvGprsRemain(String provGprsRemain) {
		this.provGprsRemain = provGprsRemain;
	}

	public List<TransFreeEntity> getProvFreeList() {
		return provFreeList;
	}

	public void setProvFreeList(List<TransFreeEntity> provFreeList) {
		this.provFreeList = provFreeList;
	}

	public List<TransFreeEntity> getFreeList() {
		return freeList;
	}

	public void setFreeList(List<TransFreeEntity> freeList) {
		this.freeList = freeList;
	}
}
