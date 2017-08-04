package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class S8248SubConInvcCompOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -589453073170774314L;

	@JSONField(name = "INVFEE_INFO")
	@ParamDesc(path = "INVFEE_INFO", cons = ConsType.CT001, type = "compx", len = "1", desc = "增值税发票项", memo = "略")
	private List<TaxInvoEntity> invFeeInfo = null;

	@JSONField(name = "INVFEE_CONT")
	@ParamDesc(path = "INVFEE_CONT", cons = ConsType.CT001, type = "int", len = "10", desc = "增值税发票项数目", memo = "略")
	private int invFeeCnt;

	public int getInvFeeCnt() {
		return invFeeCnt;
	}

	public void setInvFeeCnt(int invFeeCnt) {
		this.invFeeCnt = invFeeCnt;
	}

	public List<TaxInvoEntity> getInvFeeInfo() {
		return invFeeInfo;
	}

	public void setInvFeeInfo(List<TaxInvoEntity> invFeeInfo) {
		this.invFeeInfo = invFeeInfo;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode() */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invFeeInfo"), invFeeInfo);
		result.setRoot(getPathByProperName("invFeeCnt"), invFeeCnt);
		return result;
	}
}
