package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
  * <p>Title:   查询SP标志出参DTO</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author liuyc_billing
 * @version 1.0
 */
public class S8041GetSPFlagOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8172228855319941665L;

	
	@JSONField(name="SP_FLAG")
	@ParamDesc(path="SP_FLAG",cons=ConsType.QUES,type="String",len="1",desc="退费原因标识",memo="略")
	protected String spFlag;
	
	



	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("spFlag"), spFlag);
		return result;
	}
	
	public String getSpFlag() {
		return spFlag;
	}


	public void setSpFlag(String spFlag) {
		this.spFlag = spFlag;
	}
}
