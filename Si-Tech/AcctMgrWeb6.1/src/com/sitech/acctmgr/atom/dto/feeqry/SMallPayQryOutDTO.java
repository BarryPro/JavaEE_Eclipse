package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.PayIntEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SMallPayQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="PAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费列表",memo="略")
	private List<PayIntEntity> paymentList = new ArrayList<PayIntEntity>();
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("paymentList"), paymentList);
		
		return result;
	}

	/**
	 * @return the paymentList
	 */
	public List<PayIntEntity> getPaymentList() {
		return paymentList;
	}

	/**
	 * @param paymentList the paymentList to set
	 */
	public void setPaymentList(List<PayIntEntity> paymentList) {
		this.paymentList = paymentList;
	}
}
