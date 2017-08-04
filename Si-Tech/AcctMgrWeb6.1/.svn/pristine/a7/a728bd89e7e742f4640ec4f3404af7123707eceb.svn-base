package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.GrpRedEntity;
import com.sitech.acctmgr.atom.domains.query.SubCardEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SJtzzQryOutDTO extends CommonOutDTO{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name="NUM")
	@ParamDesc(path = "NUM", cons = ConsType.QUES, desc = "返回条数", len = "10", type = "String", memo = "")
    private String num;
    
	@JSONField(name="RESULT_LIST")
	@ParamDesc(path = "RESULT_LIST", cons = ConsType.STAR, type = "complex", len = "1", desc = "红包转账明细列表", memo = "")
	private List<GrpRedEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody(getPathByProperName("num"), num);
		result.setBody(getPathByProperName("resultList"), resultList);
		return result;
	}

	/**
	 * @return the num
	 */
	public String getNum() {
		return num;
	}

	/**
	 * @param num the num to set
	 */
	public void setNum(String num) {
		this.num = num;
	}

	/**
	 * @return the resultList
	 */
	public List<GrpRedEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<GrpRedEntity> resultList) {
		this.resultList = resultList;
	}
}
