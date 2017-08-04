package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class LocationCodeEntity {
	
    @JSONField(name = "FLAG_CODE")
    @ParamDesc(path = "FLAG_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "二批代码", memo = "")
    private String flagCode;  
    
    @JSONField(name = "VISIT_AREA_CODE")
    @ParamDesc(path = "VISIT_AREA_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "漫游地", memo = "")
    private String visitAreaCode;
    
    @JSONField(name = "LAC_CODE")
    @ParamDesc(path = "LAC_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "计费小区代码", memo = "")
    private String lacCode;
    
    @JSONField(name = "CELL_ID")
    @ParamDesc(path = "CELL_ID", cons = ConsType.CT001, len = "14", type = "string", desc = "基站代码", memo = "")
    private String cellId;
    
    @JSONField(name = "BEGIN_DATE")
    @ParamDesc(path = "BEGIN_DATE", cons = ConsType.CT001, len = "10", type = "string", desc = "生效时间", memo = "")
    private String beginDate;
    
    @JSONField(name = "END_DATE")
    @ParamDesc(path = "END_DATE", cons = ConsType.CT001, len = "10", type = "string", desc = "失效时间", memo = "")
    private String endDate;
    
    @JSONField(name = "NOTE")
    @ParamDesc(path = "NOTE", cons = ConsType.CT001, len = "100", type = "string", desc = "备注", memo = "")
    private String note;

	/**
	 * @return the flagCode
	 */
	public String getFlagCode() {
		return flagCode;
	}

	/**
	 * @param flagCode the flagCode to set
	 */
	public void setFlagCode(String flagCode) {
		this.flagCode = flagCode;
	}

	/**
	 * @return the lacCode
	 */
	public String getLacCode() {
		return lacCode;
	}

	/**
	 * @param lacCode the lacCode to set
	 */
	public void setLacCode(String lacCode) {
		this.lacCode = lacCode;
	}

	/**
	 * @return the cellId
	 */
	public String getCellId() {
		return cellId;
	}

	/**
	 * @param cellId the cellId to set
	 */
	public void setCellId(String cellId) {
		this.cellId = cellId;
	}

	/**
	 * @return the beginDate
	 */
	public String getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * @return the visitAreaCode
	 */
	public String getVisitAreaCode() {
		return visitAreaCode;
	}

	/**
	 * @param visitAreaCode the visitAreaCode to set
	 */
	public void setVisitAreaCode(String visitAreaCode) {
		this.visitAreaCode = visitAreaCode;
	}
}
