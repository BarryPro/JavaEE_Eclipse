package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.hsf.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293InDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5601005327525116651L;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="20",desc="虚拟集团标识",memo="略")
	private String unitId;
	@ParamDesc(path="BUSI_INFO.UNIT_NAME",cons=ConsType.QUES,type="String",len="100",desc="虚拟集团名称",memo="略")
	private String unitName;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());
		if(StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("unitName")))) {
			setUnitName(arg0.getObject(getPathByProperName("unitName")).toString());
		}
		
	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
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
}
