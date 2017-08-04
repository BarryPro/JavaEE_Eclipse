package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8241QryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7366362680051675024L;

	@JSONField(name = "VIRTUAL_GRP_INFO")
	@ParamDesc(path = "VIRTUAL_GRP_INFO", cons = ConsType.CT001, type = "compx", len = "1", desc = "集团成员列表", memo = "略")
	private List<VirtualGrpEntity> virtualList = new ArrayList<VirtualGrpEntity>();

	@JSONField(name = "UNIT_ID")
	@ParamDesc(path = "UNIT_ID", cons = ConsType.CT001, type = "compx", len = "1", desc = "集团ID", memo = "略")
	private String unitId;

	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.CT001, type = "compx", len = "1", desc = "集团名称", memo = "略")
	private String unitName;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("virtualList"), this.virtualList);
		result.setRoot(getPathByProperName("unitId"), this.unitId);
		result.setRoot(getPathByProperName("unitName"), this.unitName);
		return result;
	}

	public List<VirtualGrpEntity> getVirtualList() {
		return virtualList;
	}

	public void setVirtualList(List<VirtualGrpEntity> virtualList) {
		this.virtualList = virtualList;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

}
