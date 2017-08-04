package com.sitech.acctmgr.atom.domains.balance;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class BalanceDisplayListEntity implements Serializable {
	
	@JSONField(name="VALID_LIST")
	@ParamDesc(path="VALID_LIST",cons=ConsType.CT001,type="compx",len="1",desc="已生效列表",memo="略")
	private List<BalanceEntity> validList = null;
	
	@JSONField(name="EFF_PREPAY_LIST")
	@ParamDesc(path="EFF_PREPAY_LIST",cons=ConsType.CT001,type="compx",len="1",desc="将要生效列表",memo="略")
	private List<BalanceEntity> effPrepayList = null;
	
	@JSONField(name="Exp_PREPAY_LIST")
	@ParamDesc(path="Exp_PREPAY_LIST",cons=ConsType.CT001,type="compx",len="1",desc="失效列表",memo="略")
	private List<BalanceEntity> expPrepayList = null;
	
	@JSONField(name="EFF_LIST")
	@ParamDesc(path="EFF_LIST",cons=ConsType.CT001,type="compx",len="1",desc="返费列表",memo="略")
	private List<BalanceEntity> effList = null;
	
	@JSONField(name="BALANCE_DETAIL_ENT")
	@ParamDesc(path="BALANCE_DETAIL_ENT",cons=ConsType.CT001,type="compx",len="1",desc="账户明细实体",memo="略")
	private BalanceDetailEntity balanceDetailEnt;

	/**
	 * @return the validList
	 */
	public List<BalanceEntity> getValidList() {
		return validList;
	}

	/**
	 * @param validList the validList to set
	 */
	public void setValidList(List<BalanceEntity> validList) {
		this.validList = validList;
	}

	/**
	 * @return the effPrepayList
	 */
	public List<BalanceEntity> getEffPrepayList() {
		return effPrepayList;
	}

	/**
	 * @param effPrepayList the effPrepayList to set
	 */
	public void setEffPrepayList(List<BalanceEntity> effPrepayList) {
		this.effPrepayList = effPrepayList;
	}

	/**
	 * @return the expPrepayList
	 */
	public List<BalanceEntity> getExpPrepayList() {
		return expPrepayList;
	}

	/**
	 * @param expPrepayList the expPrepayList to set
	 */
	public void setExpPrepayList(List<BalanceEntity> expPrepayList) {
		this.expPrepayList = expPrepayList;
	}

	/**
	 * @return the effList
	 */
	public List<BalanceEntity> getEffList() {
		return effList;
	}

	/**
	 * @param effList the effList to set
	 */
	public void setEffList(List<BalanceEntity> effList) {
		this.effList = effList;
	}

	/**
	 * @return the balanceDetailEnt
	 */
	public BalanceDetailEntity getBalanceDetailEnt() {
		return balanceDetailEnt;
	}

	/**
	 * @param balanceDetailEnt the balanceDetailEnt to set
	 */
	public void setBalanceDetailEnt(BalanceDetailEntity balanceDetailEnt) {
		this.balanceDetailEnt = balanceDetailEnt;
	}
	
}
