package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.detail.QueryTypeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

public class SGetDetailTypeOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="DETAILTYPE_LIST")
	@ParamDesc(path="DETAILTYPE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="详单类型列表",memo="略")
	private List<QueryTypeEntity> detailTypeList;
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("detailTypeList"), detailTypeList);

		return result;
	}



	/**
	 * @return the detailTypeList
	 */
	public List<QueryTypeEntity> getDetailTypeList() {
		return detailTypeList;
	}



	/**
	 * @param detailTypeList the detailTypeList to set
	 */
	public void setDetailTypeList(List<QueryTypeEntity> detailTypeList) {
		this.detailTypeList = detailTypeList;
	}
	
}
