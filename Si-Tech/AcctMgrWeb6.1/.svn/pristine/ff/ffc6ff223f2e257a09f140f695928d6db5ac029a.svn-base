package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
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
public class S8240DisabledInvoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -939270329172640327L;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "发票号", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "String", len = "20", desc = "打印日期", memo = "略")
	private int yearMonth;

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		invNo = arg0.getStr(getPathByProperName("invNo"));
		invCode = arg0.getStr(getPathByProperName("invCode"));
		yearMonth = ValueUtils.intValue(arg0.getStr(getPathByProperName("yearMonth")));
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

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

}
