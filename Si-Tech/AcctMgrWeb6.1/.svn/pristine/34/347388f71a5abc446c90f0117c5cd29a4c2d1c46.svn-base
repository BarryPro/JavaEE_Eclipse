package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.GroupInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDistrictRegionGetRegionListOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7637314662589639228L;
	
	@JSONField(name="LIST_CITIES")
	@ParamDesc(path="LIST_CITIES",cons=ConsType.STAR,type="compx",len="1",desc="地区市列表",memo="略")
	protected List<GroupInfoEntity> listCities;

	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("listCities"), listCities);
		return result;
		}
	
	public List<GroupInfoEntity> getListCities() {
		return listCities;
	}

	public void setListCities(List<GroupInfoEntity> listCities) {
		this.listCities = listCities;
	}
}
