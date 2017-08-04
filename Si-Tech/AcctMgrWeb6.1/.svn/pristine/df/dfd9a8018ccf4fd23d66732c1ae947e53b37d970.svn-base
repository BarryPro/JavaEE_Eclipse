package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class S8068QueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -2358685064242903117L;

	@JSONField(name = "PAY_SN")
	@ParamDesc(path = "PAY_SN", cons = ConsType.CT001, type = "String", len = "100", desc = "缴费流水", memo = "略")
	private long paySn;

	@JSONField(name = "TOTAL_DATE")
	@ParamDesc(path = "TOTAL_DATE", cons = ConsType.CT001, type = "String", len = "100", desc = "缴费时间", memo = "略")
	private int totalDate;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("paySn"), this.paySn);
		result.setRoot(getPathByProperName("totalDate"), this.totalDate);
		return result;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}


}
