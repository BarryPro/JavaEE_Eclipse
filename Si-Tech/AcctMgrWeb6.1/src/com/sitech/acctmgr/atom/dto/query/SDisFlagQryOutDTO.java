package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.DisFlagEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDisFlagQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="RESULT_LIST")
	@ParamDesc(path="RESULT_LIST",cons=ConsType.STAR,type="compx",len="1",desc="结果列表",memo="略")
	private List<DisFlagEntity> resultList;
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);

		return result;
	}



	/**
	 * @return the resultList
	 */
	public List<DisFlagEntity> getResultList() {
		return resultList;
	}



	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<DisFlagEntity> resultList) {
		this.resultList = resultList;
	}
}
