package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.SmsBackPayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SIvrBackPayInitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6155025017898276036L;
	
	@ParamDesc(path="PAY_ALL",cons=ConsType.CT001,type="String",len="15",desc="总返费金额",memo="略")
	protected String payAll = "";
	
	@ParamDesc(path="BACK_LIST",cons=ConsType.STAR,type="compx",len="1",desc="返费信息列表",memo="略")
	protected List<SmsBackPayEntity> backList = new ArrayList<SmsBackPayEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payAll"), payAll);
		result.setRoot(getPathByProperName("backList"), backList);

		return result;
	}

	/**
	 * @return the payAll
	 */
	public String getPayAll() {
		return payAll;
	}

	/**
	 * @param payAll the payAll to set
	 */
	public void setPayAll(String payAll) {
		this.payAll = payAll;
	}

	/**
	 * @return the backList
	 */
	public List<SmsBackPayEntity> getBackList() {
		return backList;
	}

	/**
	 * @param backList the backList to set
	 */
	public void setBackList(List<SmsBackPayEntity> backList) {
		this.backList = backList;
	}
	
}
