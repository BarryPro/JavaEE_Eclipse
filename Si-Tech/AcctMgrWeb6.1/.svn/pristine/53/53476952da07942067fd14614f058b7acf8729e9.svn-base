package com.sitech.acctmgr.atom.domains.cct;


import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class CreditOpenEntity {

	@JSONField(name="ARPUScore")
	@ParamDesc(path="ARPUScore",cons=ConsType.CT001,len="6",desc="月均消费额得分",type="String",memo="略")
	protected String ARPUScore;
	@JSONField(name="NetAgeScore")
	@ParamDesc(path="NetAgeScore",cons=ConsType.CT001,len="6",desc="网龄得分",type="String",memo="略")
	protected String netAgeScore;
	/*
	@JSONField(name="AddScoreInfo")
    @ParamDesc(path = "AddScoreInfo", cons = ConsType.PLUS, type = "complex", len = "256", desc = "加分项", memo = "列表")
    private List<AddScoreEntity> addScoreList;
    */
	@JSONField(name="DedScore")
	@ParamDesc(path="DedScore",cons=ConsType.CT001,len="6",desc="减分项得分",type="String",memo="略")
	protected String dedScore;
	/**
	 * @return the aRPUScore
	 */
	public String getARPUScore() {
		return ARPUScore;
	}
	/**
	 * @param aRPUScore the aRPUScore to set
	 */
	public void setARPUScore(String aRPUScore) {
		ARPUScore = aRPUScore;
	}
	/**
	 * @return the netAgeScore
	 */
	public String getNetAgeScore() {
		return netAgeScore;
	}
	/**
	 * @param netAgeScore the netAgeScore to set
	 */
	public void setNetAgeScore(String netAgeScore) {
		this.netAgeScore = netAgeScore;
	}

	/**
	 * @return the dedScore
	 */
	public String getDedScore() {
		return dedScore;
	}
	/**
	 * @param dedScore the dedScore to set
	 */
	public void setDedScore(String dedScore) {
		this.dedScore = dedScore;
	}
}
