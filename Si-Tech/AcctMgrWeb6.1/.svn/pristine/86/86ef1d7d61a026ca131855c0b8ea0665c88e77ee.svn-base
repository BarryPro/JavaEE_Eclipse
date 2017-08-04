package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PaysnBaseEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;
 
/**
 *
 * <p>Title: 根据帐户信息去查询流水信息出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 *  modify  by LIJXD  20150227
 *  增加出参： PAYSN_LEN 流水记录条数
 */
public class S8056GetSnInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7512673011641870817L;
	
	@JSONField(name="PAYSN_LIST")
	@ParamDesc(path="PAYSN_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费列表",memo="略")
	protected	List<PaysnBaseEntity> paysnInfo ;
	@JSONField(name="PAYSN_LEN")
	@ParamDesc(path="PAYSN_LEN",cons=ConsType.CT001,type="String",len="8",desc="缴费数量",memo="略")
	protected 	int  paysnLen =0;
	
	public MBean encode(){
		MBean result = super.encode();
		result.setRoot(getPathByProperName("paysnInfo"), paysnInfo);
		if(paysnLen==0){
			paysnLen=paysnInfo.size();
		}
		result.setRoot(getPathByProperName("paysnLen"), paysnLen);
		return result;
	}
	

/*	public S8056GetSnInfoOutDTO(){
	}
	 
	public S8056GetSnInfoOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.paysnInfo = (List<Map<String, Object>>) mBean.getBodyList("OUT_DATA.PAYSN_LIST");
	}*/

 

	/**
	 * @return the paysnLen
	 */
	public int getPaysnLen() {
		return paysnLen;
	}


	/**
	 * @return the paysnInfo
	 */
	public List<PaysnBaseEntity> getPaysnInfo() {
		return paysnInfo;
	}


	/**
	 * @param paysnInfo the paysnInfo to set
	 */
	public void setPaysnInfo(List<PaysnBaseEntity> paysnInfo) {
		this.paysnInfo = paysnInfo;
	}


	/**
	 * @param paysnLen the paysnLen to set
	 */
	public void setPaysnLen(int paysnLen) {
		this.paysnLen = paysnLen;
	}


 
	 
	
	
}
