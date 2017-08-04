package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.FeiDouQryEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>
* Title: 飞豆充值记录查询出参DTO
* </p>
* <p>
* Description: 飞豆充值记录查询出参DTO
* </p>
* <p>
* Copyright: Copyright (c) 2014
* </p>
* <p>
* Company: SI-TECH
* </p>
* 
* @author liuyc_billing
* @version 1.0
*/
public class S8073QryInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1485869331562800861L;
	
	@ParamDesc(path = "LEN_FEIDOU_LIST", cons = ConsType.STAR, type = "long", len = "10", desc = "飞豆充值列表长度", memo = "略")
    private int lenFeiDouList;
	@ParamDesc(path = "FEIDOU_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "飞豆充值信息列表", memo = "略")
    private List<FeiDouQryEntity>  FeiDouList;
	
	 @Override
	    public MBean encode() {
	        MBean result = super.encode();
	        result.setBody(getPathByProperName("lenFeiDouList"), lenFeiDouList);
	        result.setBody(getPathByProperName("FeiDouList"), FeiDouList);
	        return result;
	    }

	public int getLenFeiDouList() {
		return lenFeiDouList;
	}

	public void setLenFeiDouList(int lenFeiDouList) {
		this.lenFeiDouList = lenFeiDouList;
	}

	public List<FeiDouQryEntity> getFeiDouList() {
		return FeiDouList;
	}

	public void setFeiDouList(List<FeiDouQryEntity> feiDouList) {
		FeiDouList = feiDouList;
	}	 

}
