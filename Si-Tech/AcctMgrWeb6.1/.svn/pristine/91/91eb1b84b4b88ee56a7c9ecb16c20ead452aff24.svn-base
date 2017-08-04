package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.ClassifyPreEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SClassifyPreInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2506327718583649944L;
	
	@ParamDesc(path="RETURN_LIST",cons=ConsType.STAR,type="compx",len="1",desc="预存分类信息列表",memo="略")
	protected List<ClassifyPreEntity> returnList = new ArrayList<ClassifyPreEntity>();
	
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
	public List<ClassifyPreEntity> getReturnList() {
		return returnList;
	}

	/**
	 * @param returnList the returnList to set
	 */
	public void setReturnList(List<ClassifyPreEntity> returnList) {
		this.returnList = returnList;
	}
	
}
