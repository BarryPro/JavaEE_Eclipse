package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SpecialTransBnCheckOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6374158259288715672L;

	@ParamDesc(path="TRANS_FEE",cons=ConsType.CT001,type="long",len="18",desc="可转余额",memo="")
	private long transFee;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("transFee"), transFee);
		return result;
	}

	public long getTransFee() {
		return transFee;
	}

	public void setTransFee(long transFee) {
		this.transFee = transFee;
	}
	
}
