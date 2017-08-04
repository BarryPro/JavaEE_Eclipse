package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 名称：月结发票打印分月打印和合并打印需要传入的inv_no和bill_cycle列表
 * 
 * @author liuhl_bj
 *
 */
public class InvBillCycleEntity {

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, len = "6", desc = "打印账期", type = "int", memo = "略")
	private int billCycle;

	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.CT001, len = "6", desc = "发票号码", type = "string", memo = "略")
	private String invNo;

	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.CT001, len = "6", desc = "发票代码", type = "string", memo = "略")
	private String invCode;

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	@Override
	public String toString() {
		return "InvBillCycleEntity [billCycle=" + billCycle + ", invNo=" + invNo + ", invCode=" + invCode + "]";
	}

}
