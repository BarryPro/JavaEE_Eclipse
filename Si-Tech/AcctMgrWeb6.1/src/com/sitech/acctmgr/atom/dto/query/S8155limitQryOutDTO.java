package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.TransLimitEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8155limitQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3196395371925720025L;
	@JSONField(name="RESULT_LIST")
	@ParamDesc(path="RESULT_LIST",cons=ConsType.STAR,type="complex",len="1",desc="操作员赠送信息列表",memo="略")
	private List<TransLimitEntity> resultList = new ArrayList<TransLimitEntity>();
	
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
	public List<TransLimitEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<TransLimitEntity> resultList) {
		this.resultList = resultList;
	}


}
