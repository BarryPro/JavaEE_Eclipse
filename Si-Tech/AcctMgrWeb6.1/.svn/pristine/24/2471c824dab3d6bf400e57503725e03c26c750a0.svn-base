package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.base.ChngroupDictEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDistrictRegionGetDistrictListOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="LIST_DISTRICTS")
	@ParamDesc(path="LIST_DISTRICTS",cons=ConsType.STAR,type="compx",len="1",desc="区县列表",memo="略")
	protected List<ChngroupDictEntity> listDistricts;

	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("listDistricts"), listDistricts);
		return result;
		}

	public List<ChngroupDictEntity> getListDistricts() {
		return listDistricts;
	}

	public void setListDistricts(List<ChngroupDictEntity> listDistricts) {
		this.listDistricts = listDistricts;
	}
	
	
	
}
