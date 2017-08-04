package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.InterRoamProdInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SInterRoamUsageQryOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "INFO_LIST", desc = "国漫用户使用信息列表", cons = ConsType.CT001, type = "complex", len = "1", memo = "列表")
	private List<InterRoamProdInfoEntity> infoList;
	
    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("infoList"), infoList);
        
        return result;
    }

	public List<InterRoamProdInfoEntity> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<InterRoamProdInfoEntity> infoList) {
		this.infoList = infoList;
	}
	
}
