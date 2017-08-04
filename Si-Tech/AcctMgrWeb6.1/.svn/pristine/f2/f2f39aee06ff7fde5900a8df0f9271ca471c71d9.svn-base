package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.ProvCriticalEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8120QryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULTLIST",cons=ConsType.STAR,type="compx",len="1",desc="边界漫游列表",memo="略")
	List<ProvCriticalEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);

		log.info(result.toString());
		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<ProvCriticalEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<ProvCriticalEntity> resultList) {
		this.resultList = resultList;
	}

	
}
