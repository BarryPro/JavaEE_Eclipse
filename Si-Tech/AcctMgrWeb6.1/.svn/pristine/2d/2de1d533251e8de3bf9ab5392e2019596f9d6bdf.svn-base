package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillDisplayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8107QryBillOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1402213526831197248L;
	
	@ParamDesc(path="BILL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="账单列表",memo="略")
	private List<BillDisplayEntity> billList = new ArrayList<BillDisplayEntity>();
	@ParamDesc(path="USER_TOTAL",cons=ConsType.CT001,type="int",len="8",desc="用户个数",memo="略")
	private int userTotal = 0;

	
	/**
	 * @return the userTotal
	 */
	public int getUserTotal() {
		return userTotal;
	}

	/**
	 * @param userTotal the userTotal to set
	 */
	public void setUserTotal(int userTotal) {
		this.userTotal = userTotal;
	}

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("billList"), billList);
		result.setRoot(getPathByProperName("userTotal"), userTotal);
		return result;
	}

	/**
	 * @return the billList
	 */
	public List<BillDisplayEntity> getBillList() {
		return billList;
	}

	/**
	 * @param billList the billList to set
	 */
	public void setBillList(List<BillDisplayEntity> billList) {
		this.billList = billList;
	}

	
	
	
}
