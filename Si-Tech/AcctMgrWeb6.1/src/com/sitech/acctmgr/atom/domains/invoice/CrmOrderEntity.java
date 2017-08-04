package com.sitech.acctmgr.atom.domains.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class CrmOrderEntity {

	@JSONField(name = "ORDER_INFO")
	@ParamDesc(path = "ORDER_INFO", cons = ConsType.QUES, type = "compx", len = "100", desc = "订单信息", memo = "略")
	private List<CRMOrderInfoEntity> crmOrderlist;

	public List<CRMOrderInfoEntity> getCrmOrderlist() {
		return crmOrderlist;
	}

	public void setCrmOrderlist(List<CRMOrderInfoEntity> crmOrderlist) {
		this.crmOrderlist = crmOrderlist;
	}

	@Override
	public String toString() {
		return "CrmOrderEntity [crmOrderlist=" + crmOrderlist + "]";
	}

}
