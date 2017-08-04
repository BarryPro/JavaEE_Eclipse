package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.balance.BatchpayInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBackPayQryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="PAY_ALL",cons=ConsType.CT001,type="long",len="20",desc="返费总金额",memo="单位：分")
	private long payAll = 0;
	@ParamDesc(path = "RESULT_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "返回列表", memo = "略")
	private List<BatchpayInfoEntity> resultList = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);
		result.setRoot(getPathByProperName("payAll"), payAll);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<BatchpayInfoEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<BatchpayInfoEntity> resultList) {
		this.resultList = resultList;
	}

	/**
	 * @return the payAll
	 */
	public long getPayAll() {
		return payAll;
	}

	/**
	 * @param payAll the payAll to set
	 */
	public void setPayAll(long payAll) {
		this.payAll = payAll;
	}


}
