package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title: 陈死账回收查询出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author linzc
 * @version 1.0
 */
public class S8007CfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6138294653146152411L;
	
	@JSONField(name="BACK_SN")
	@ParamDesc(path="BACK_SN",cons=ConsType.CT001,type="long",len="40",desc="流水",memo="略")
	protected	long backSn;

	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("backSn"), backSn);
		return result;
	}

	/**
	 * @return the backSn
	 */
	public long getBackSn() {
		return backSn;
	}

	/**
	 * @param backSn the backSn to set
	 */
	public void setBackSn(long backSn) {
		this.backSn = backSn;
	}

}
