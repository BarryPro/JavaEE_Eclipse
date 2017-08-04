package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.RedFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8155InitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3196395371925720025L;
	@JSONField(name="REDFEEINFO")
	@ParamDesc(path="REDFEEINFO",cons=ConsType.STAR,type="compx",len="1",desc="红包赠送列表",memo="略")
	private List<RedFeeEntity> redFeeInfo = new ArrayList<RedFeeEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("redFeeInfo"), redFeeInfo);

		return result;
	}

	/**
	 * @return the redFeeInfo
	 */
	public List<RedFeeEntity> getRedFeeInfo() {
		return redFeeInfo;
	}

	/**
	 * @param redFeeInfo the redFeeInfo to set
	 */
	public void setRedFeeInfo(List<RedFeeEntity> redFeeInfo) {
		this.redFeeInfo = redFeeInfo;
	}

}
