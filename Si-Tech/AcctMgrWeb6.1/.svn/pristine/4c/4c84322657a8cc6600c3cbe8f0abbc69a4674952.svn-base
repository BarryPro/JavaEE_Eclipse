package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.base.ChngroupDictEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SDistrictRegionQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 3412519368130730229L;

	@JSONField(name="DIS_LIST")
	@ParamDesc(path="DIS_LIST",cons= ConsType.STAR,type="compx",len="1",desc="区县列表信息",memo="略")
	private List<ChngroupDictEntity> disGroupList;

	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons= ConsType.STAR,type="String",len="1",desc="归属地市名称",memo="略")
	private String regionName;

	@JSONField(name="REGION_CODE")
	@ParamDesc(path="REGION_CODE",cons=ConsType.STAR,type="compx",len="1",desc="归属地市代码",memo="略")
	private String regionCode;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("disGroupList"), disGroupList);
		result.setRoot(getPathByProperName("regionName"), regionName);
		result.setRoot(getPathByProperName("regionCode"), regionCode);

		return result;
	}

	public List<ChngroupDictEntity> getDisGroupList() {
		return disGroupList;
	}

	public void setDisGroupList(List<ChngroupDictEntity> disGroupList) {
		this.disGroupList = disGroupList;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	@Override
	public String toString() {
		return "SDistrictRegionQueryOutDTO{" +
				"disGroupList=" + disGroupList +
				", regionName='" + regionName + '\'' +
				", regionCode='" + regionCode + '\'' +
				'}';
	}
}
