package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.CRMIntellPrtEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupRelConInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCRMIntellPrtQueryOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="INTELL_PRT_LIST",cons=ConsType.CT001,type="compx",len="1",desc="智能终端CRM缴费信息",memo="略")
	private List<CRMIntellPrtEntity> intellPrtList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setBody(getPathByProperName("intellPrtList"), intellPrtList);
		return result;
	}

	/**
	 * @return the intellPrtList
	 */
	public List<CRMIntellPrtEntity> getIntellPrtList() {
		return intellPrtList;
	}

	/**
	 * @param intellPrtList the intellPrtList to set
	 */
	public void setIntellPrtList(List<CRMIntellPrtEntity> intellPrtList) {
		this.intellPrtList = intellPrtList;
	}

}
