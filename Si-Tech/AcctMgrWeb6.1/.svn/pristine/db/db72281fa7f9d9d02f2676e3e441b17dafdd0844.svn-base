package com.sitech.acctmgr.atom.dto.cct;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.cct.NonStopEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8258NonStopOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULT_LIST",cons=ConsType.STAR,type="compx",len="1",desc="免停信息列表",memo="略")
	protected List<NonStopEntity> resultList = new ArrayList<NonStopEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);

		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<NonStopEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<NonStopEntity> resultList) {
		this.resultList = resultList;
	}
}
