package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.AdjBackMoneyInitEntity;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8041InitOutDTO extends CommonOutDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8060939533625915389L;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo;
	@JSONField(name="LIST_ADJSUBTYPE")
	@ParamDesc(path="LIST_ADJSUBTYPE",cons=ConsType.STAR,type="compx",len="1",desc="核减类型",memo="略")
	protected List<AdjBackMoneyInitEntity> adjSubTypeList;
	@JSONField(name="LIST_ADJBILLTYPE")
	@ParamDesc(path="LIST_ADJBILLTYPE",cons=ConsType.STAR,type="compx",len="1",desc="计费类型",memo="略")
	protected List<AdjBackMoneyInitEntity> adjBillTypeList;
	
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("adjSubTypeList"),adjSubTypeList);
		result.setRoot(getPathByProperName("adjBillTypeList"), adjBillTypeList);
		return result;
	}
	
	

	public List<AdjBackMoneyInitEntity> getAdjSubTypeList() {
		return adjSubTypeList;
	}


	public void setAdjSubTypeList(List<AdjBackMoneyInitEntity> adjSubTypeList) {
		this.adjSubTypeList = adjSubTypeList;
	}


	public List<AdjBackMoneyInitEntity> getAdjBillTypeList() {
		return adjBillTypeList;
	}


	public void setAdjBillTypeList(List<AdjBackMoneyInitEntity> adjBillTypeList) {
		this.adjBillTypeList = adjBillTypeList;
	}
	
	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

}
