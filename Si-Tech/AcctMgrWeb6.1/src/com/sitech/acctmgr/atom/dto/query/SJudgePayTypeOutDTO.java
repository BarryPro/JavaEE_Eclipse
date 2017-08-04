package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SJudgePayTypeOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="JUDGE_FLAG")
	@ParamDesc(path = "JUDGE_FLAG", cons = ConsType.CT001, desc = "捆绑标识", len = "1", type = "String", memo = "")
    private String judgeFlag;
	@JSONField(name="REASON_NOTE")
	@ParamDesc(path = "REASON_NOTE", cons = ConsType.CT001, desc = "不能捆绑原因说明", len = "100", type = "String", memo = "")
    private String reasonNote;
	@JSONField(name="EFFECT_TIME")
	@ParamDesc(path = "EFFECT_TIME", cons = ConsType.CT001, desc = "捆绑生效时间", len = "14", type = "String", memo = "")
    private String effectTime;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody(getPathByProperName("judgeFlag"), judgeFlag);
		result.setBody(getPathByProperName("reasonNote"), reasonNote);
		result.setBody(getPathByProperName("effectTime"), effectTime);
		return result;
	}

	/**
	 * @return the judgeFlag
	 */
	public String getJudgeFlag() {
		return judgeFlag;
	}

	/**
	 * @param judgeFlag the judgeFlag to set
	 */
	public void setJudgeFlag(String judgeFlag) {
		this.judgeFlag = judgeFlag;
	}

	/**
	 * @return the reasonNote
	 */
	public String getReasonNote() {
		return reasonNote;
	}

	/**
	 * @param reasonNote the reasonNote to set
	 */
	public void setReasonNote(String reasonNote) {
		this.reasonNote = reasonNote;
	}

	/**
	 * @return the effectTime
	 */
	public String getEffectTime() {
		return effectTime;
	}

	/**
	 * @param effectTime the effectTime to set
	 */
	public void setEffectTime(String effectTime) {
		this.effectTime = effectTime;
	}
}
