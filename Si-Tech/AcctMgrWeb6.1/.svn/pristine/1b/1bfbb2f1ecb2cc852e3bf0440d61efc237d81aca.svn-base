package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl
 *
 */
public class SQryShortRemindAuthOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6865694133929271599L;

	@JSONField(name = "RET_CODE")
	@ParamDesc(path = "RET_CODE", cons = ConsType.QUES, type = "string", len = "10", desc = "返回错误代码", memo = "返回000002表示用户没有权限接收短信提醒")
	private String retCode;

	@JSONField(name = "RET_MSG")
	@ParamDesc(path = "RET_MSG", cons = ConsType.QUES, type = "string", len = "10", desc = "返回错误信息", memo = "返回000002表示用户没有权限接收短信提醒")
	private String retMsg;

	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result = super.encode();
		result.setRoot(getPathByProperName("retCode"), retCode);
		result.setRoot(getPathByProperName("retMsg"), retMsg);

		return result;
	}

}
