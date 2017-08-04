package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.GrpFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8422InitOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "RESULT_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "返回列表", memo = "略")
	private List<GrpFeeEntity> resultList = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
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
	public List<GrpFeeEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<GrpFeeEntity> resultList) {
		this.resultList = resultList;
	}
}
