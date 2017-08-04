package com.sitech.acctmgr.common.domains;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 小权限实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class LoginPdomEntity implements Serializable {

	@JSONField(name = "BUSI_CODE")
	@ParamDesc(path="BUSI_CODE",cons=ConsType.CT001,type="String",len="10",desc="小权限编码",memo="略")
	private String busiCode;
	
	@JSONField(name = "CHECK_FLAG")
	@ParamDesc(path="CHECK_FLAG",cons=ConsType.CT001,type="String",len="1",desc="校验结果标识",memo="Y-有权限，N-没权限")
	private String checkFlag;
	

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "LoginPdomEntity [busiCode=" + busiCode + ", checkFlag=" + checkFlag + "]";
	}

	/**
	 * @return the busiCode
	 */
	public String getBusiCode() {
		return busiCode;
	}

	/**
	 * @param busiCode the busiCode to set
	 */
	public void setBusiCode(String busiCode) {
		this.busiCode = busiCode;
	}

	/**
	 * @return the checkFlag
	 */
	public String getCheckFlag() {
		return checkFlag;
	}

	/**
	 * @param checkFlag the checkFlag to set
	 */
	public void setCheckFlag(String checkFlag) {
		this.checkFlag = checkFlag;
	}
	
	
}
