package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.atom.domains.detail.DynamicTable;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

public class SDetailDynamicRawQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 8838165671510924111L;

	@ParamDesc(path = "ATTR_LIST", cons = ConsType.CT001, len = "", type = "complex", desc = "", memo = "")
	private List<DynamicTable> tables = new ArrayList<DynamicTable>();

	@Override
	public MBean encode() {
		MBean m = super.encode();
		m.setRoot(getPathByProperName("tables"), tables);
		return m;
	}

	public List<DynamicTable> getTables() {
		return tables;
	}

	public void setTables(List<DynamicTable> tables) {
		this.tables = tables;
	}
}
