package com.sitech.acctmgr.atom.dto.cct;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.cct.GrpRedEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8258QryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RETURN_LIST",cons=ConsType.STAR,type="compx",len="1",desc="预存分类信息列表",memo="略")
	protected List<GrpRedEntity> returnList = new ArrayList<GrpRedEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("returnList"), returnList);

		return result;
	}

	/**
	 * @return the returnList
	 */
	public List<GrpRedEntity> getReturnList() {
		return returnList;
	}

	/**
	 * @param returnList the returnList to set
	 */
	public void setReturnList(List<GrpRedEntity> returnList) {
		this.returnList = returnList;
	}


}
