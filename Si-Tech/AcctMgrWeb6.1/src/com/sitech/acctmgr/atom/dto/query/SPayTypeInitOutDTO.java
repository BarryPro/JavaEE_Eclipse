package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PayTypeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayTypeInitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3752947669397864401L;
	
	@JSONField(name="PAYTYPE_LIST")
	@ParamDesc(path="PAYTYPE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="支付类型列表",memo="略")
	private List<PayTypeEntity> payTypeList = new ArrayList<PayTypeEntity>();
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payTypeList"), payTypeList);

		return result;
	}



	/**
	 * @return the payTypeList
	 */
	public List<PayTypeEntity> getPayTypeList() {
		return payTypeList;
	}



	/**
	 * @param payTypeList the payTypeList to set
	 */
	public void setPayTypeList(List<PayTypeEntity> payTypeList) {
		this.payTypeList = payTypeList;
	}
}
