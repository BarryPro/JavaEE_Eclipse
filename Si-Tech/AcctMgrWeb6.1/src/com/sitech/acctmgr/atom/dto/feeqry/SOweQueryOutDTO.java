package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SOweQueryOutDTO extends CommonOutDTO {
	

	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BILL_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "账单列表", memo = "略")
	private List<BillEntity> outList = null;

	@Override
	public MBean encode() {

		MBean result = super.encode();			
		result.setRoot(getPathByProperName("outList"), outList);
		return result;
	}

	public List<BillEntity> getOutList() {
		return outList;
	}

	public void setOutList(List<BillEntity> outList) {
		this.outList = outList;
	}

	
}
