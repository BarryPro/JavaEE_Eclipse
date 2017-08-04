package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class SpecBalaceEntity extends BalanceEntity{
	
	
	@JSONField(name="SPECIAL_FLAG")
	@ParamDesc(path="SPECIAL_FLAG",cons=ConsType.CT001,type="String",len="1",desc="专款标识",memo="0：专款  1：普通账本")
	private String specialFlag = "0";


	public String getSpecialFlag() {
		return specialFlag;
	}

	public void setSpecialFlag(String specialFlag) {
		this.specialFlag = specialFlag;
	}
	
	
}
