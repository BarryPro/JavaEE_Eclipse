package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8412OweBillQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="OWEFEE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="欠费列表",memo="略")
	private List<OweFeeEntity> oweFeeList = new ArrayList<OweFeeEntity>();
	
	public MBean encode(){
		MBean result = super.encode();
		result.setRoot(getPathByProperName("oweFeeList"), oweFeeList);
		
		return result;
	}

	/**
	 * @return the oweFeeList
	 */
	public List<OweFeeEntity> getOweFeeList() {
		return oweFeeList;
	}

	/**
	 * @param oweFeeList the oweFeeList to set
	 */
	public void setOweFeeList(List<OweFeeEntity> oweFeeList) {
		this.oweFeeList = oweFeeList;
	}
}
