package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.sitech.acctmgr.atom.domains.adj.BalCustRefundEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8084ListSPInfoOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2211004063526014541L;
	
	
	
	@ParamDesc(path = "LEN_BAL_CUSTREFUND_LIST", cons = ConsType.STAR, type = "long", len = "10", desc = "sp列表长度", memo = "略")
    private long lenBalCustRefund;
	
	@ParamDesc(path = "BAL_CUSTREFUND_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "sp信息列表", memo = "略")
    private List<BalCustRefundEntity> balCustRefundList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setBody(getPathByProperName("balCustRefundList"), balCustRefundList);
        result.setBody(getPathByProperName("lenBalCustRefund"), lenBalCustRefund);
        return result;
    }

	public long getLenBalCustRefund() {
		return lenBalCustRefund;
	}

	public void setLenBalCustRefund(long lenBalCustRefund) {
		this.lenBalCustRefund = lenBalCustRefund;
	}

	public List<BalCustRefundEntity> getBalCustRefundList() {
		return balCustRefundList;
	}

	public void setBalCustRefundList(List<BalCustRefundEntity> balCustRefundList) {
		this.balCustRefundList = balCustRefundList;
	}

	  
}
