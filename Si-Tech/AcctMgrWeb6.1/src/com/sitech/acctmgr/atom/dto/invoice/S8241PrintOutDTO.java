package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8241PrintOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7366362680051675024L;

	@JSONField(name = "INV_OCCUPY")
	@ParamDesc(path = "INV_OCCUPY", cons = ConsType.PLUS, type = "compx", len = "1", desc = "打印出参", memo = "略")
	private InvNoOccupyEntity invNoOccupy;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invNoOccupy"), this.invNoOccupy);
		return result;
	}

	public InvNoOccupyEntity getInvNoOccupy() {
		return invNoOccupy;
	}

	public void setInvNoOccupy(InvNoOccupyEntity invNoOccupy) {
		this.invNoOccupy = invNoOccupy;
	}

}
