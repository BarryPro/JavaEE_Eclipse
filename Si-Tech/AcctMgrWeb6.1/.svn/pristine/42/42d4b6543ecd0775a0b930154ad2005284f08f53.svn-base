package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293InitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 290564958225559467L;
	@JSONField(name="VIRTUALINFO")
	@ParamDesc(path="VIRTUALINFO",cons=ConsType.STAR,type="compx",len="1",desc="虚拟集团信息列表",memo="略")
	private List<VirtualGrpEntity> virtualInfo = new ArrayList<VirtualGrpEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("virtualInfo"), virtualInfo);

		return result;
	}



	/**
	 * @return the virtualInfo
	 */
	public List<VirtualGrpEntity> getVirtualInfo() {
		return virtualInfo;
	}



	/**
	 * @param virtualInfo the virtualInfo to set
	 */
	public void setVirtualInfo(List<VirtualGrpEntity> virtualInfo) {
		this.virtualInfo = virtualInfo;
	}
}
