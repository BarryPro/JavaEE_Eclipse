package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.atom.domains.bill.PayItemCodeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8418InitOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULTLIST",cons=ConsType.STAR,type="compx",len="1",desc="账目项列表",memo="略")
	List<PayItemCodeEntity> resultList;
	
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
	public List<PayItemCodeEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<PayItemCodeEntity> resultList) {
		this.resultList = resultList;
	}

}
