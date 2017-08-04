package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.dt.MBean;

public class WPrePayCardCfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3092700793834687145L;

	@Override
	public MBean encode(){
		MBean result=super.encode();
		return result;
	}
}
