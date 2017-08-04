package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.PrcDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPrcDetailQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "DETAIL_LIST", desc = "详细列表", cons = ConsType.CT001, type = "complex", len = "1", memo = "列表")
	private List<PrcDetailEntity> detailList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("detailList"), detailList);
		return result;
	}

	public List<PrcDetailEntity> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<PrcDetailEntity> detailList) {
		this.detailList = detailList;
	}

	

	

}
