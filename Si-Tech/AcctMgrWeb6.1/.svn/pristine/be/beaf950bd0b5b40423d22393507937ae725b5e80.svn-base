package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8010QueryGiveInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8948898427260832076L;
	
	
	@JSONField(name="LEN_GIVEFEE")
	@ParamDesc(path="LEN_GIVEFEE",cons=ConsType.CT001,type="int",len="10",desc="送费明细长度",memo="略")
	protected int lenGiveFee;
	@JSONField(name="LIST_GIVEFEE")
	@ParamDesc(path="LIST_GIVEFEE",cons=ConsType.STAR,type="compx",len="1",desc="送费明细",memo="略")
	protected List<PubCodeDictEntity> listGiveFee;
	
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("lenGiveFee"), lenGiveFee);
		result.setRoot(getPathByProperName("listGiveFee"), listGiveFee);
		return result;
	}



	public int getLenGiveFee() {
		return lenGiveFee;
	}



	public void setLenGiveFee(int lenGiveFee) {
		this.lenGiveFee = lenGiveFee;
	}



	public List<PubCodeDictEntity> getListGiveFee() {
		return listGiveFee;
	}



	public void setListGiveFee(List<PubCodeDictEntity> listGiveFee) {
		this.listGiveFee = listGiveFee;
	}
	
	

}
