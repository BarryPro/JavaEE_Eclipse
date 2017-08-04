package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditQueryForCrmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 889052532757948645L;
	@ParamDesc(path = "BUSI_INFO.CREDIT_CLASS", cons = ConsType.CT001, type = "String", len = "10", desc = "信用度等级", memo = "a:五星钻,b:五星金,c:五星普通,d:四星,e:三星,f:二星,g:一星,h:准星,A:未评级")
	String creditClass = "";
	
	 public String getCreditClass() {
		return creditClass;
	}

	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}

	@Override
	    public MBean encode() {

	    	MBean result = super.encode();																																		
	        result.setRoot(getPathByProperName("creditClass"), creditClass);																							
	        log.info(result.toString());																																				
	        return result;
	    }
}
