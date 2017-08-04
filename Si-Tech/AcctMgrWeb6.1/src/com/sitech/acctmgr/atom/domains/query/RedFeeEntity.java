package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class RedFeeEntity {

	@JSONField(name="UNIT_ID")
	@ParamDesc(path="UNIT_ID",cons=ConsType.CT001,type="long",len="18",desc="集团编码",memo="无")
	protected long unitId;
	
	@JSONField(name="UNIT_NAME")
	@ParamDesc(path="UNIT_NAME",cons=ConsType.CT001,type="String",len="40",desc="集团名称",memo="无")
	protected String unitName;
	
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="40",desc="地市",memo="无")
	protected String regionName;
	
	@JSONField(name="DIS_NAME")
	@ParamDesc(path="DIS_NAME",cons=ConsType.CT001,type="String",len="40",desc="区县",memo="无")
	protected String disName;
	
	@JSONField(name="CONTACT_PHONE")
	@ParamDesc(path="CONTACT_PHONE",cons=ConsType.CT001,type="String",len="40",desc="联系人电话",memo="无")
	protected String contactPhone;
	
	@JSONField(name="SERVICE_PHONE")
	@ParamDesc(path="SERVICE_PHONE",cons=ConsType.CT001,type="String",len="40",desc="客服电话",memo="无")
	protected String servicePhone;
	
	@JSONField(name="PRODPRC_NAME")
	@ParamDesc(path="PRODPRC_NAME",cons=ConsType.CT001,type="String",len="40",desc="资费名称",memo="无")
	protected String prodPrcName;
	
	@JSONField(name="TRANS_COUNT")
	@ParamDesc(path="TRANS_COUNT",cons=ConsType.CT001,type="int",len="8",desc="红包个数",memo="无")
	protected int transCount;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="14",desc="操作时间",memo="无")
	protected String opTime;

	/**
	 * @return the unitId
	 */
	public long getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	/**
	 * @return the unitName
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * @param unitName the unitName to set
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @return the disName
	 */
	public String getDisName() {
		return disName;
	}

	/**
	 * @param disName the disName to set
	 */
	public void setDisName(String disName) {
		this.disName = disName;
	}

	/**
	 * @return the contactPhone
	 */
	public String getContactPhone() {
		return contactPhone;
	}

	/**
	 * @param contactPhone the contactPhone to set
	 */
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * @return the servicePhone
	 */
	public String getServicePhone() {
		return servicePhone;
	}

	/**
	 * @param servicePhone the servicePhone to set
	 */
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	/**
	 * @return the prodPrcName
	 */
	public String getProdPrcName() {
		return prodPrcName;
	}

	/**
	 * @param prodPrcName the prodPrcName to set
	 */
	public void setProdPrcName(String prodPrcName) {
		this.prodPrcName = prodPrcName;
	}

	/**
	 * @return the transCount
	 */
	public int getTransCount() {
		return transCount;
	}

	/**
	 * @param transCount the transCount to set
	 */
	public void setTransCount(int transCount) {
		this.transCount = transCount;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

}
