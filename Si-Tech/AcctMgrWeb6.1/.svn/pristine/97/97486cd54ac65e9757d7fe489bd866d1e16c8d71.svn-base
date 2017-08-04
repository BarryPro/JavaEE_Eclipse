package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 资费ID信息实体
 * 
 * @author xuezm
 *
 */
public class PrcIdTransEntity {
	
	@JSONField(name = "PRC_ID")
	@ParamDesc(path = "PRC_ID", cons = ConsType.CT001, type = "String", len = "20", desc = "资费定价代码", memo = "略")
	private String prcId;
	
	@JSONField(name = "DETAIL_CODE")
	@ParamDesc(path = "DETAIL_CODE", cons = ConsType.CT001, type = "String", len = "4", desc = "二批代码", memo = "略")
	private String detailCode;
	
	@JSONField(name = "DETAIL_NOTE")
	@ParamDesc(path = "DETAIL_NOTE", cons = ConsType.CT001, type = "String", len = "60", desc = "二批注释", memo = "略")
	private String detailNote;
	
	@JSONField(name = "DETAIL_TYPE")
	@ParamDesc(path = "DETAIL_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "二批类型", memo = "略")
	private String detailType;
	
	@JSONField(name = "DETAIL_TYPE_NAME")
	@ParamDesc(path = "DETAIL_TYPE_NAME", cons = ConsType.CT001, type = "String", len = "1", desc = "二批类型名称", memo = "略")
	private String detailTypeName;

	@JSONField(name = "BARGAINPARA_FLAG")
	@ParamDesc(path = "BARGAINPARA_FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "交易", memo = "略")
	private String bargainparaFlag;

	@JSONField(name = "REGION_CODE")
	@ParamDesc(path = "REGION_CODE", cons = ConsType.CT001, type = "String", len = "4", desc = "资费适用地市代码", memo = "略")
	private String regionCode;
	

	public String getPrcId() {
		return prcId;
	}
	
	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}
	
	public String getDetailCode() {
		return detailCode;
	}
	
	public void setDetailCode(String detailCode) {
		this.detailCode = detailCode;
	}
	
	public String getDetailNote() {
		return detailNote;
	}
	
	public void setDetailNote(String detailNote) {
		this.detailNote = detailNote;
	}
	
	public String getDetailType() {
		return detailType;
	}
	
	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}
	
	public String getBargainparaFlag() {
		return bargainparaFlag;
	}
	
	public void setBargainparaFlag(String bargainparaFlag) {
		this.bargainparaFlag = bargainparaFlag;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getDetailTypeName() {
		return detailTypeName;
	}

	public void setDetailTypeName(String detailTypeName) {
		this.detailTypeName = detailTypeName;
	}

	@Override
	public String toString() {
		return "PrcIdTransEntity [prcId=" + prcId + ", detailCode=" + detailCode + ", detailNote=" + detailNote + ", detailType=" + detailType
				+ ", detailTypeName=" + detailTypeName + ", bargainparaFlag=" + bargainparaFlag + ", regionCode=" + regionCode + "]";
	}


}
