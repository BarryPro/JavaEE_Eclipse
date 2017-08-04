package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8297SignOutDTO extends CommonOutDTO {
	

	@JSONField(name="LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="40",desc="签约流水",memo="略")
	private String loginAccept;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		return result;
	}


	/**
	 * @return the loginAccept
	 */
	public String getLoginAccept() {
		return loginAccept;
	}


	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}

}
