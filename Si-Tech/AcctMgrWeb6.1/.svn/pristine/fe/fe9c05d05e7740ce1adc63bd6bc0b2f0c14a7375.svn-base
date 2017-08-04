package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class S8068PrintInDTO extends CommonInDTO {

	private static final long serialVersionUID = 2437286863730547360L;

	@ParamDesc(path = "BUSI_INFO.PAY_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "缴费流水", memo = "略")
	private long paySn;

	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "int", len = "20", desc = "缴费时间", memo = "略")
	private int yearMonth;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		paySn = ValueUtils.longValue(arg0.getStr(getPathByProperName("paySn")));
		yearMonth = ValueUtils.intValue(arg0.getStr(getPathByProperName("yearMonth")));
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

}
