package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSmashEggInitOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4312067127796852357L;
	
	@ParamDesc(path="SMASH_COUNT",cons=ConsType.CT001,type="int",len="8",desc="砸蛋次数",memo="略")
	protected int smashCount = 0;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("smashCount"), smashCount);

		return result;
	}

	/**
	 * @return the smashCount
	 */
	public int getSmashCount() {
		return smashCount;
	}

	/**
	 * @param smashCount the smashCount to set
	 */
	public void setSmashCount(int smashCount) {
		this.smashCount = smashCount;
	}
}
