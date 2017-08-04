package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/13.
 */
public class SFreeVpmnQueryInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "String", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.QUES, desc = "账务月份", len = "6", type = "string", memo = "格式为YYYYMM；")
	private int yearMonth;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		if (StringUtils.isEmptyOrNull(yearMonth) || yearMonth == 0) {
			// 获取当前年月日
			yearMonth = DateUtils.getCurYm();
		} else {
			yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
		}
		log.debug("year_month:" + yearMonth);
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}
}
