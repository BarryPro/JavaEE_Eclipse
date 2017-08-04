package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.SmsBackPayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayFlagQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="FLAG_THIRTY",cons=ConsType.CT001,type="String",len="1",desc="缴费30标志",memo="1：有缴费30元的记录")
	protected String flagThirty = "";
	@ParamDesc(path="FLAG_FIFTY",cons=ConsType.CT001,type="String",len="1",desc="缴费50标志",memo="1：有缴费50元的记录")
	protected String flagFifty = "";
	@ParamDesc(path="FLAG_EIGHTY",cons=ConsType.CT001,type="String",len="1",desc="缴费80标志",memo="1：有缴费80元的记录")
	protected String flagEighty = "";
	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("flagThirty"), flagThirty);
		result.setRoot(getPathByProperName("flagFifty"), flagFifty);
		result.setRoot(getPathByProperName("flagEighty"), flagEighty);

		return result;
	}


	/**
	 * @return the flagThirty
	 */
	public String getFlagThirty() {
		return flagThirty;
	}


	/**
	 * @param flagThirty the flagThirty to set
	 */
	public void setFlagThirty(String flagThirty) {
		this.flagThirty = flagThirty;
	}


	/**
	 * @return the flagFifty
	 */
	public String getFlagFifty() {
		return flagFifty;
	}


	/**
	 * @param flagFifty the flagFifty to set
	 */
	public void setFlagFifty(String flagFifty) {
		this.flagFifty = flagFifty;
	}


	/**
	 * @return the flagEighty
	 */
	public String getFlagEighty() {
		return flagEighty;
	}


	/**
	 * @param flagEighty the flagEighty to set
	 */
	public void setFlagEighty(String flagEighty) {
		this.flagEighty = flagEighty;
	}
	
}
