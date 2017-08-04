package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.record.UserChgRecdEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SUserStopTimeQryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULT_LIST",cons=ConsType.STAR,type="compx",len="1",desc="返回结果列表",memo="略")
	protected List<UserChgRecdEntity> resultList = new ArrayList<UserChgRecdEntity>();
	
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
	public List<UserChgRecdEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<UserChgRecdEntity> resultList) {
		this.resultList = resultList;
	}
}
