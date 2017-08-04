package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.Pay1500QryEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPay1500QryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="PAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费列表",memo="略")
	protected List<Pay1500QryEntity> payList = new ArrayList<Pay1500QryEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payList"), payList);

		return result;
	}

	/**
	 * @return the payList
	 */
	public List<Pay1500QryEntity> getPayList() {
		return payList;
	}

	/**
	 * @param payList the payList to set
	 */
	public void setPayList(List<Pay1500QryEntity> payList) {
		this.payList = payList;
	}
}
