package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayListEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBalanceOutDTO extends CommonOutDTO{
	
	@JSONField(name="ALL_PREPAY_TOTAL")
	@ParamDesc(path="ALL_PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="总生效预存",memo="略")
	protected long allPrepayTotal;
	
	@JSONField(name="ALL_EFF_PREPAY_TOTAL")
	@ParamDesc(path="ALL_EFF_PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="总未生效预存",memo="略")
	protected long allEffPrepayTotal;
	
	@JSONField(name="ALL_EXP_PREPAY_TOTAL")
	@ParamDesc(path="ALL_EXP_PREPAY_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="总失效预存",memo="略")
	protected long allExpPrepayTotal;
	
	@JSONField(name="CONTRACT_LIST")
	@ParamDesc(path="CONTRACT_LIST",cons=ConsType.CT001,type="compx",len="1",desc="所有帐户明细",memo="略")
	protected List<BalanceDisplayListEntity> contractList;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("allPrepayTotal"), allPrepayTotal);
		result.setRoot(getPathByProperName("allEffPrepayTotal"), allEffPrepayTotal);
		result.setRoot(getPathByProperName("allExpPrepayTotal"), allExpPrepayTotal);
		result.setBody(getPathByProperName("contractList"), contractList);
		
		return result;
	}

	/**
	 * @return the allPrepayTotal
	 */
	public long getAllPrepayTotal() {
		return allPrepayTotal;
	}

	/**
	 * @param allPrepayTotal the allPrepayTotal to set
	 */
	public void setAllPrepayTotal(long allPrepayTotal) {
		this.allPrepayTotal = allPrepayTotal;
	}

	/**
	 * @return the allEffPrepayTotal
	 */
	public long getAllEffPrepayTotal() {
		return allEffPrepayTotal;
	}

	/**
	 * @param allEffPrepayTotal the allEffPrepayTotal to set
	 */
	public void setAllEffPrepayTotal(long allEffPrepayTotal) {
		this.allEffPrepayTotal = allEffPrepayTotal;
	}

	/**
	 * @return the allExpPrepayTotal
	 */
	public long getAllExpPrepayTotal() {
		return allExpPrepayTotal;
	}

	/**
	 * @param allExpPrepayTotal the allExpPrepayTotal to set
	 */
	public void setAllExpPrepayTotal(long allExpPrepayTotal) {
		this.allExpPrepayTotal = allExpPrepayTotal;
	}

	/**
	 * @return the contractList
	 */
	public List<BalanceDisplayListEntity> getContractList() {
		return contractList;
	}

	/**
	 * @param contractList the contractList to set
	 */
	public void setContractList(List<BalanceDisplayListEntity> contractList) {
		this.contractList = contractList;
	}

	
	
}
