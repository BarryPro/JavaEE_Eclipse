package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.TellCodeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8556OutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULTLIST",cons=ConsType.STAR,type="complex",len="1",desc="扣费主动提醒短信处理列表",memo="略")
	List<TellCodeEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);

		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<TellCodeEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<TellCodeEntity> resultList) {
		this.resultList = resultList;
	}
}
