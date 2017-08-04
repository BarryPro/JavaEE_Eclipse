package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8054GetGPRSReasonOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4157360897839450895L;

	@JSONField(name="LEN_REASONINFO")
	@ParamDesc(path="LEN_REASONINFO",cons=ConsType.CT001,type="int",len="10",desc="原因业务列表长度",memo="略")
	protected int lenReasonInfo;
	
	@JSONField(name="LIST_REASONINFO")
	@ParamDesc(path="LIST_REASONINFO",cons=ConsType.STAR,type="compx",len="1",desc="原因业务列表",memo="略")
	protected List<ComplainAdjReasonEntity> listReasonInfo;
	
	
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("LEN_REASONINFO",lenReasonInfo);
		result.setBody("LIST_REASONINFO",listReasonInfo);
		return result;
	}



	/**
	 * @return the lenReasonInfo
	 */
	public int getLenReasonInfo() {
		return lenReasonInfo;
	}



	/**
	 * @param lenReasonInfo the lenReasonInfo to set
	 */
	public void setLenReasonInfo(int lenReasonInfo) {
		this.lenReasonInfo = lenReasonInfo;
	}



	/**
	 * @return the listReasonInfo
	 */
	public List<ComplainAdjReasonEntity> getListReasonInfo() {
		return listReasonInfo;
	}



	/**
	 * @param listReasonInfo the listReasonInfo to set
	 */
	public void setListReasonInfo(List<ComplainAdjReasonEntity> listReasonInfo) {
		this.listReasonInfo = listReasonInfo;
	}
}
