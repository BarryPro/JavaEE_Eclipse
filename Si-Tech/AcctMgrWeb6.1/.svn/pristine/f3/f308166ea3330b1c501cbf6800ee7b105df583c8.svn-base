package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8054GetSPInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6628780767460282476L;


	@JSONField(name="LEN_SPINFO")
	@ParamDesc(path="LEN_SPINFO",cons=ConsType.CT001,type="int",len="10",desc="SP业务列表长度",memo="略")
	protected int lenSPInfo;
	@JSONField(name="LIST_SPINFO")
	@ParamDesc(path="LIST_SPINFO",cons=ConsType.STAR,type="compx",len="1",desc="SP业务列表",memo="略")
	protected List<SpInfoEntity> listSPInfo;
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("LEN_SPINFO",lenSPInfo);
		result.setBody("LIST_SPINFO",listSPInfo);
		return result;
	}
	

	 
	public int getLenSPInfo() {
		return lenSPInfo;
	}

	public void setLenSPInfo(int lenSPInfo) {
		this.lenSPInfo = lenSPInfo;
	}

	public List<SpInfoEntity> getListSPInfo() {
		return listSPInfo;
	}

	public void setListSPInfo(List<SpInfoEntity> listSPInfo) {
		this.listSPInfo = listSPInfo;
	}

}
