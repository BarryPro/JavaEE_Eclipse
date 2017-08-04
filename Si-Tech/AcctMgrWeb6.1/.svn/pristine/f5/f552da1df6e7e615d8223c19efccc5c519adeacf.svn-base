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
public class S8006CfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7730102949116311839L;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="40",desc="流水",memo="略")
	protected	long paySn;

	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("paySn"), paySn);
		return result;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	
}
