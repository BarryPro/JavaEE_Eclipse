/**
 * 
 */
package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.atom.domains.collection.CollCodeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * @author wangyla
 * 
 */
public class S8225CollCodeOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1315605996110076948L;
	@ParamDesc(path="QUERY_LIST",cons= ConsType.QUES,type="compx",len="",desc="托收代码列表",memo="略")
	List<CollCodeEntity> collCodeList = new ArrayList<CollCodeEntity>();


	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result = new MBean();
		result.setRoot(getPathByProperName("collCodeList"), collCodeList);
		return result;
	}


	public List<CollCodeEntity> getCollCodeList() {
		return collCodeList;
	}


	public void setCollCodeList(List<CollCodeEntity> collCodeList) {
		this.collCodeList = collCodeList;
	}

}
