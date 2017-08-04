package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class ProvCriticalEntity {
    @JSONField(name = "VISIT_PROV_CODE")
    @ParamDesc(path = "VISIT_PROV_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "被访省省代码", memo = "")
    private String visitProvCode;  
    
    @JSONField(name = "MSC_ID")
    @ParamDesc(path = "MSC_ID", cons = ConsType.CT001, len = "14", type = "string", desc = "漫游MSC_ID", memo = "")
    private String mscId;
    
    @JSONField(name = "LAC_ID")
    @ParamDesc(path = "LAC_ID", cons = ConsType.CT001, len = "14", type = "string", desc = "漫游LAC_ID", memo = "")
    private String lacId;
    
    @JSONField(name = "CELL_ID")
    @ParamDesc(path = "CELL_ID", cons = ConsType.CT001, len = "14", type = "string", desc = "漫游CELL_ID", memo = "")
    private String cellId;
    
    @JSONField(name = "LOCAL_PROV_CODE")
    @ParamDesc(path = "LOCAL_PROV_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "被覆盖省代码", memo = "")
    private String localProvCode;
    
    @JSONField(name = "LOCAL_LONG_CODE")
    @ParamDesc(path = "LOCAL_LONG_CODE", cons = ConsType.CT001, len = "14", type = "string", desc = "被覆盖行政区长途区号", memo = "")
    private String localLongCode;
    
    @JSONField(name = "BEGIN_TIME")
    @ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, len = "14", type = "string", desc = "生效开始时间", memo = "")
    private String beginTime;
    
    @JSONField(name = "END_TIME")
    @ParamDesc(path = "END_TIME", cons = ConsType.CT001, len = "14", type = "string", desc = "生效结束时间", memo = "")
    private String endTime;

	@JSONField(serialize = false)
	private String flag;

	/**
	 * @return the visitProvCode
	 */
	public String getVisitProvCode() {
		return visitProvCode;
	}

	/**
	 * @param visitProvCode the visitProvCode to set
	 */
	public void setVisitProvCode(String visitProvCode) {
		this.visitProvCode = visitProvCode;
	}

	/**
	 * @return the mscId
	 */
	public String getMscId() {
		return mscId;
	}

	/**
	 * @param mscId the mscId to set
	 */
	public void setMscId(String mscId) {
		this.mscId = mscId;
	}

	/**
	 * @return the lacId
	 */
	public String getLacId() {
		return lacId;
	}

	/**
	 * @param lacId the lacId to set
	 */
	public void setLacId(String lacId) {
		this.lacId = lacId;
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
	 * @return the localProvCode
	 */
	public String getLocalProvCode() {
		return localProvCode;
	}

	/**
	 * @param localProvCode the localProvCode to set
	 */
	public void setLocalProvCode(String localProvCode) {
		this.localProvCode = localProvCode;
	}

	/**
	 * @return the localLongCode
	 */
	public String getLocalLongCode() {
		return localLongCode;
	}

	/**
	 * @param localLongCode the localLongCode to set
	 */
	public void setLocalLongCode(String localLongCode) {
		this.localLongCode = localLongCode;
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
}
