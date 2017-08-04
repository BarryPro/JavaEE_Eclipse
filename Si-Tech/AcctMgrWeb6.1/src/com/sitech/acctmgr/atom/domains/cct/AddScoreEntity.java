package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class AddScoreEntity {
	@JSONField(name="AddScoreRES")
	@ParamDesc(path="AddScoreRES",cons=ConsType.CT001,len="612",desc="加分项得分原因描述",type="String",memo="略")
	protected String addScoreRES;
	@JSONField(name="AddScore")
	@ParamDesc(path="AddScore",cons=ConsType.CT001,len="6",desc="网龄得分",type="String",memo="略")
	protected String addScore;
	/**
	 * @return the addScoreRES
	 */
	public String getAddScoreRES() {
		return addScoreRES;
	}
	/**
	 * @param addScoreRES the addScoreRES to set
	 */
	public void setAddScoreRES(String addScoreRES) {
		this.addScoreRES = addScoreRES;
	}
	/**
	 * @return the addScore
	 */
	public String getAddScore() {
		return addScore;
	}
	/**
	 * @param addScore the addScore to set
	 */
	public void setAddScore(String addScore) {
		this.addScore = addScore;
	}
}
