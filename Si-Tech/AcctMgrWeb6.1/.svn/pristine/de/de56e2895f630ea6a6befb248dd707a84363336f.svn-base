package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class OnlyShareFareEntity {
	@JSONField(name="RETRUNFEENAME")
	@ParamDesc(path="RETRUNFEENAME",cons=ConsType.CT001,type="String",len="256",desc="赠送返还项目名称",memo="略")
	private String ReturnFeeName = "";
	
	@JSONField(name="RETURN_FEE")
	@ParamDesc(path="RETURN_FEE",cons=ConsType.CT001,type="long",len="20",desc="预存/赠送总金额",memo="单位：分")
	private String returnFee = "";
	
	@JSONField(name="RETURN_TIME")
	@ParamDesc(path="RETURN_TIME",cons=ConsType.CT001,type="String",len="16",desc="到账时间",memo="YYYYMMDD")
	private String ReturnTime = "";
	
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.CT001,type="String",len="16",desc="状态",memo="0：已到账 1：未到账")
	private String status = "";



	public String getReturnFeeName() {
		return ReturnFeeName;
	}

	public void setReturnFeeName(String returnFeeName) {
		ReturnFeeName = returnFeeName;
	}

	public String getReturnFee() {
		return returnFee;
	}

	public void setReturnFee(String returnFee) {
		this.returnFee = returnFee;
	}

	public String getReturnTime() {
		return ReturnTime;
	}

	public void setReturnTime(String returnTime) {
		ReturnTime = returnTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	

	
	
}
