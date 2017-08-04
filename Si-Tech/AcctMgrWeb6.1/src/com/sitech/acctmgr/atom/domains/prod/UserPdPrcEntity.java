package com.sitech.acctmgr.atom.domains.prod;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class UserPdPrcEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@JSONField(name = "PROD_PRC_ID")
	@ParamDesc(path = "PROD_PRC_ID", type = "string", cons = ConsType.CT001, desc = "可选套餐模板代码", len = "10", memo = "略")
	private String prodPrcId;

	@JSONField(name = "PROD_PRC_NAME")
	@ParamDesc(path = "PROD_PRC_NAME", type = "string", cons = ConsType.CT001, desc = "可选套餐模板名称", len = "10", memo = "略")
	private String prodPrcName;

	@JSONField(name = "EFF_DATE")
	@ParamDesc(path = "EFF_DATE", type = "string", cons = ConsType.CT001, desc = "开始时间", len = "10", memo = "略")
	private String effDate;

	@JSONField(name = "EXP_DATE")
	@ParamDesc(path = "EXP_DATE", type = "string", cons = ConsType.CT001, desc = "结束时间", len = "10", memo = "略")
	private String expDate;

	@JSONField(name = "STATE_DATE")
	@ParamDesc(path = "STATE_DATE", type = "string", cons = ConsType.CT001, desc = "操作时间", len = "10", memo = "略")
	private String stateDate;

	@JSONField(name = "RATE_CODE")
	@ParamDesc(path = "RATE_CODE", type = "string", cons = ConsType.CT001, desc = "二批代码", len = "10", memo = "略")
	private String rateCode;

	public String getProdPrcId() {
		return prodPrcId;
	}

	public void setProdPrcId(String prodPrcId) {
		this.prodPrcId = prodPrcId;
	}

	public String getProdPrcName() {
		return prodPrcName;
	}

	public void setProdPrcName(String prodPrcName) {
		this.prodPrcName = prodPrcName;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getStateDate() {
		return stateDate;
	}

	public void setStateDate(String stateDate) {
		this.stateDate = stateDate;
	}

	public String getRateCode() {
		return rateCode;
	}

	public void setRateCode(String rateCode) {
		this.rateCode = rateCode;
	}

}
