package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8556InDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.QUES,type="String",len="14",desc="开始时间",memo="略")
	private String beginTime;

	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.QUES,type="String",len="14",desc="结束时间",memo="")
	private String endTime;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
		
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}
