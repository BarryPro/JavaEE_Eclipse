package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.RefundEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SRefundOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "REFUND_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "账单列表", memo = "略")
	private List<RefundEntity> refundList = null;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("refundList"), refundList);
		return result;
	}

	public List<RefundEntity> getRefundList() {
		return refundList;
	}

	public void setRefundList(List<RefundEntity> refundList) {
		this.refundList = refundList;
	}

}
