package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class S8076InvoicePrintOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "INV_NO_OCCUPY", desc = "发票信息", cons = ConsType.QUES, type = "complex", len = "", memo = "")
	private InvNoOccupyEntity invNoOccupy;

	@Override
	public MBean encode() {

		MBean result = new MBean();
		result.setRoot(getPathByProperName("invNoOccupy"), invNoOccupy);
		return result;

	}

	public InvNoOccupyEntity getInvNoOccupy() {
		return invNoOccupy;
	}

	public void setInvNoOccupy(InvNoOccupyEntity invNoOccupy) {
		this.invNoOccupy = invNoOccupy;
	}

}
