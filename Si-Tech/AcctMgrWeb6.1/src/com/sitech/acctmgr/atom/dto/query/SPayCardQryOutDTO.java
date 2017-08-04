package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.PayCardQryEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayCardQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3752947669397864401L;
	
	@JSONField(name="PAYCARD_LIST")
	@ParamDesc(path="PAYCARD_LIST",cons=ConsType.STAR,type="complex",len="1",desc="充值卡信息列表",memo="略")
	private List<PayCardQryEntity> payCardList = new ArrayList<PayCardQryEntity>();
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payCardList"), payCardList);

		return result;
	}



	/**
	 * @return the payCardList
	 */
	public List<PayCardQryEntity> getPayCardList() {
		return payCardList;
	}



	/**
	 * @param payCardList the payCardList to set
	 */
	public void setPayCardList(List<PayCardQryEntity> payCardList) {
		this.payCardList = payCardList;
	}


}
