package com.sitech.acctmgr.atom.dto.cct;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditQryDetailOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name="CREDIT_CLASS")
	@ParamDesc(path = "CREDIT_CLASS", cons = ConsType.QUES, type = "String", len = "1", desc = "客户星级", memo = "略")
	protected String creditClass;
	
	@JSONField(name="CREDIT_NAME")
	@ParamDesc(path = "CREDIT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "客户星级名称", memo = "略")
	protected String creditName;
	
	@JSONField(name="START_TIME")
	@ParamDesc(path = "START_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "评级生效时间", memo = "略")
	protected String startTime;
	
	@JSONField(name="END_TIME")
	@ParamDesc(path = "END_TIME", cons = ConsType.QUES, type = "String", len = "14", desc = "评级到期时间", memo = "略")
	protected String endTime;
	
	@JSONField(name="BASE_SCORE")
	@ParamDesc(path = "BASE_SCORE", cons = ConsType.QUES, type = "long", len = "10", desc = "基础得分", memo = "略")
	protected long baseScore;
	
	@JSONField(name="ADD_SCORE")
	@ParamDesc(path = "ADD_SCORE", cons = ConsType.QUES, type = "long", len = "10", desc = "加分值", memo = "略")
	protected long addScore;
	
	@JSONField(name="LESS_SCORE")
	@ParamDesc(path = "LESS_SCORE", cons = ConsType.QUES, type = "long", len = "10", desc = "减分值", memo = "略")
	protected long lessScore;
	
	@JSONField(name="ALL_SCORE")
	@ParamDesc(path = "ALL_SCORE", cons = ConsType.QUES, type = "long", len = "10", desc = "总分", memo = "略")
	protected long allScore;
	
	@JSONField(name="DETAIL_LIST")
	@ParamDesc(path = "DETAIL_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "信誉度明细列表", memo = "略")
	protected List<CreditDetailEntity> detailList;
	
	
	
	/*
	@JSONField(name="ADJ_FLAG")
	@ParamDesc(path = "ADJ_FLAG", cons = ConsType.QUES, type = "String", len = "1", desc = "评级到期标志", memo = "Y-是, N-否")
	protected String adjFlag;
	*/
	
	@Override
	public MBean encode() {
		MBean result = super.encode();

		result.setRoot(getPathByProperName("creditClass"), creditClass);
		result.setRoot(getPathByProperName("creditName"), creditName);
		result.setRoot(getPathByProperName("startTime"), startTime);
		result.setRoot(getPathByProperName("endTime"), endTime);
		result.setRoot(getPathByProperName("baseScore"), baseScore);
		result.setRoot(getPathByProperName("addScore"), addScore);
		result.setRoot(getPathByProperName("lessScore"), lessScore);
		result.setRoot(getPathByProperName("allScore"), allScore);
		result.setRoot(getPathByProperName("detailList"), detailList);
		//result.setRoot(getPathByProperName("adjFlag"), adjFlag);
		log.info(result.toString());
		return result;
	}



	/**
	 * @return the creditClass
	 */
	public String getCreditClass() {
		return creditClass;
	}



	/**
	 * @param creditClass the creditClass to set
	 */
	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}



	/**
	 * @return the startTime
	 */
	public String getStartTime() {
		return startTime;
	}



	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}



	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}



	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}



	/**
	 * @return the baseScore
	 */
	public long getBaseScore() {
		return baseScore;
	}



	/**
	 * @param baseScore the baseScore to set
	 */
	public void setBaseScore(long baseScore) {
		this.baseScore = baseScore;
	}



	/**
	 * @return the addScore
	 */
	public long getAddScore() {
		return addScore;
	}



	/**
	 * @param addScore the addScore to set
	 */
	public void setAddScore(long addScore) {
		this.addScore = addScore;
	}



	/**
	 * @return the lessScore
	 */
	public long getLessScore() {
		return lessScore;
	}



	/**
	 * @param lessScore the lessScore to set
	 */
	public void setLessScore(long lessScore) {
		this.lessScore = lessScore;
	}



	/**
	 * @return the allScore
	 */
	public long getAllScore() {
		return allScore;
	}



	/**
	 * @param allScore the allScore to set
	 */
	public void setAllScore(long allScore) {
		this.allScore = allScore;
	}



	/**
	 * @return the detailList
	 */
	public List<CreditDetailEntity> getDetailList() {
		return detailList;
	}



	/**
	 * @param detailList the detailList to set
	 */
	public void setDetailList(List<CreditDetailEntity> detailList) {
		this.detailList = detailList;
	}



	public String getCreditName() {
		return creditName;
	}



	public void setCreditName(String creditName) {
		this.creditName = creditName;
	}


	
}
