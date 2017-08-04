package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.AdjOweEntity;
import com.sitech.acctmgr.atom.domains.query.RedFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8124InitOutDTO extends CommonOutDTO{

	@JSONField(name="ADJOWEINFO")
	@ParamDesc(path="ADJOWEINFO",cons=ConsType.STAR,type="compx",len="1",desc="调帐信息列表",memo="略")
	private List<AdjOweEntity> adjOweInfo = new ArrayList<AdjOweEntity>();
	
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("adjOweInfo"), adjOweInfo);

		return result;
	}



	/**
	 * @return the adjOweInfo
	 */
	public List<AdjOweEntity> getAdjOweInfo() {
		return adjOweInfo;
	}



	/**
	 * @param adjOweInfo the adjOweInfo to set
	 */
	public void setAdjOweInfo(List<AdjOweEntity> adjOweInfo) {
		this.adjOweInfo = adjOweInfo;
	}
}
