package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.GrpBillDispByStatusEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8412QryBillDetailOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1402213526831197248L;

	@ParamDesc(path = "BILL_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "账单列表", memo = "略")
	private List<GrpBillDispByStatusEntity> billList = new ArrayList<GrpBillDispByStatusEntity>();

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("billList"), billList);
		return result;
	}

	public List<GrpBillDispByStatusEntity> getBillList() {
		return billList;
	}

	public void setBillList(List<GrpBillDispByStatusEntity> billList) {
		this.billList = billList;
	}

}
