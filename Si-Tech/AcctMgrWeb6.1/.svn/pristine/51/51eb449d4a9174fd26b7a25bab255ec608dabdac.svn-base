package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.List;

import com.sitech.acctmgr.atom.domains.collection.CollBillDetInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/5.
 */
public class SCollectionBillQueryOutDTO extends CommonOutDTO{
    private static final long serialVersionUID = -1L;

    @ParamDesc(path = "BILL_LIST", desc = "托收账单详细列表", cons = ConsType.CT001, type = "List", len = "1", memo = "")
	private List<CollBillDetInfoEntity> billList;
    
    @ParamDesc(path = "COUNT", cons = ConsType.CT001, len = "5", type = "int", desc = "账单数量", memo = "")
    private int count;
    
    @ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "总金额", memo = "")
    private long totalFee;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		
		result.setRoot(getPathByProperName("billList"), billList);
		result.setRoot(getPathByProperName("count"), count);
		result.setRoot(getPathByProperName("totalFee"), totalFee);
		
		return result;
	}

	public List<CollBillDetInfoEntity> getBillList() {
		return billList;
	}

	public void setBillList(List<CollBillDetInfoEntity> billList) {
		this.billList = billList;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}
	
}
