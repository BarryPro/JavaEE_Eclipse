package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S3101QryInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.CT001, type = "long", len = "20", desc = "查询类型", memo = "0:按月份查询    1：按日期查询")
	private int qryType;

	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "long", len = "20", desc = "查询年月", memo = "略")
	private int yearMonth;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.CT001, type = "long", len = "20", desc = "开始时间", memo = "略")
	private int beginDate;

	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.CT001, type = "long", len = "20", desc = "结束时间", memo = "略")
	private int endDate;

	// @ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "long", len = "20", desc = "页码", memo = "略")
	// private int pageNum;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		qryType = ValueUtils.intValue(arg0.getStr(getPathByProperName("qryType")));
		// pageNum = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageNum")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("yearMonth")))) {
			yearMonth = ValueUtils.intValue(arg0.getStr(getPathByProperName("yearMonth")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginDate")))) {
			beginDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginDate")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endDate")))) {
			endDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("endDate")));
		}
	}

	// public int getPageNum() {
	// return pageNum;
	// }
	//
	// public void setPageNum(int pageNum) {
	// this.pageNum = pageNum;
	// }

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

	public int getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	public int getEndDate() {
		return endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

	public int getQryType() {
		return qryType;
	}

	public void setQryType(int qryType) {
		this.qryType = qryType;
	}

}
