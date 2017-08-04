package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8224PrintOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8535608260842777813L;
	@JSONField(name = "INV_NO_OCCUPY")
	@ParamDesc(path = "INV_NO_OCCUPY", cons = ConsType.CT001, type = "compx", len = "1", desc = "发票打印模板列表", memo = "略")
	private List<InvNoOccupyEntity> invNoOccupy;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invNoOccupy"), invNoOccupy);
		return result;
	}

	public List<InvNoOccupyEntity> getInvNoOccupy() {
		return invNoOccupy;
	}

	public void setInvNoOccupy(List<InvNoOccupyEntity> invNoOccupy) {
		this.invNoOccupy = invNoOccupy;
	}

}
