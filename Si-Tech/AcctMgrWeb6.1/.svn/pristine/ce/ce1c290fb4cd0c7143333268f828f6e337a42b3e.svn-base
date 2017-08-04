package com.sitech.acctmgr.atom.dto.invoice;

import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPrintBankPrintOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4671065283533784774L;

	@JSONField(name = "LINE_MAP")
	@ParamDesc(path = "LINE_MAP", cons = ConsType.QUES, type = "map", len = "20", desc = "map", memo = "略")
	private Map<String, Object> lineMap;

	@Override
	public MBean encode() {

		MBean result = new MBean();
		result.setRoot(getPathByProperName("lineMap"), lineMap);
		return result;

	}

	public Map<String, Object> getLineMap() {
		return lineMap;
	}

	public void setLineMap(Map<String, Object> lineMap) {
		this.lineMap = lineMap;
	}

}
