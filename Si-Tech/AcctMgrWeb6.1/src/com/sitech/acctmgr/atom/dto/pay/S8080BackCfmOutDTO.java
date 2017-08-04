package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 欠费催缴确认服务出参 </p>
* <p>Description:   </p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8080BackCfmOutDTO extends CommonOutDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 9099254084146314504L;
	
	@JSONField(name="RETURN_CODE")
	@ParamDesc(path="RETURN_CODE",cons=ConsType.CT001,type="String",len="40",desc="返回代码",memo="略")
	protected String returnCode;
	@JSONField(name="RETURN_MSG")
	@ParamDesc(path="RETURN_MSG",cons=ConsType.CT001,type="String",len="40",desc="返回信息",memo="略")
	protected String returnMsg;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("returnCode"), returnCode);
		result.setRoot(getPathByProperName("returnMsg"), returnMsg);
		return result;
	}


	public String getReturnCode() {
		return returnCode;
	}


	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}


	public String getReturnMsg() {
		return returnMsg;
	}
}
