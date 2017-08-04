package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.OnlyFareEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SGiveReturnQryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="FAV_LIST")
	@ParamDesc(path="FAV_LIST",cons=ConsType.STAR,type="compx",len="1",desc="赠送与返还话费查询信息列表",memo="略")
	private List<OnlyFareEntity> favList = new ArrayList<OnlyFareEntity>();
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("favList"), favList);
		return result;
	}

	public List<OnlyFareEntity> getFavList() {
		return favList;
	}

	public void setFavList(List<OnlyFareEntity> favList) {
		this.favList = favList;
	}
}
