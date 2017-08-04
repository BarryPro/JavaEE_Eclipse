package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8226QueryOrPrintInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "string", len = "20", desc = "账务日期", memo = "略")
	private int yearMonth;

	@ParamDesc(path = "BUSI_INFO.GROUP_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "区县ID", memo = "略")
	private String groupId;

	@ParamDesc(path = "BUSI_INFO.BEGIN_BANK", cons = ConsType.CT001, type = "string", len = "20", desc = "开始银行", memo = "略")
	private String beginBank;

	@ParamDesc(path = "BUSI_INFO.END_BANK", cons = ConsType.CT001, type = "string", len = "20", desc = "结束银行", memo = "略")
	private String endBank;

	@ParamDesc(path = "BUSI_INFO.BEGIN_PRINT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "开始流水", memo = "略")
	private String beginPrintNo;

	@ParamDesc(path = "BUSI_INFO.END_PRINT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "结束流水", memo = "略")
	private String endPrintNo;

	@ParamDesc(path = "BUSI_INFO.PRINT_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "打印类型", memo = "1：打印   2：重打")
	private int printType;

	@ParamDesc(path = "BUSI_INFO.PRINT_FLAG", cons = ConsType.CT001, type = "String", len = "20", desc = "是否打印", memo = "0:不打印   1：打印")
	private int printFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		yearMonth = ValueUtils.intValue(arg0.getStr(getPathByProperName("yearMonth")));
		groupId = arg0.getStr(getPathByProperName("groupId"));
		beginBank = arg0.getStr(getPathByProperName("beginBank"));
		endBank = arg0.getStr(getPathByProperName("endBank"));
		beginPrintNo = arg0.getStr(getPathByProperName("beginPrintNo"));
		endPrintNo = arg0.getStr(getPathByProperName("endPrintNo"));
		printFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("printFlag")));
		printType = ValueUtils.intValue(arg0.getStr(getPathByProperName("printType")));
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getBeginBank() {
		return beginBank;
	}

	public void setBeginBank(String beginBank) {
		this.beginBank = beginBank;
	}

	public String getEndBank() {
		return endBank;
	}

	public void setEndBank(String endBank) {
		this.endBank = endBank;
	}

	public String getBeginPrintNo() {
		return beginPrintNo;
	}

	public void setBeginPrintNo(String beginPrintNo) {
		this.beginPrintNo = beginPrintNo;
	}

	public String getEndPrintNo() {
		return endPrintNo;
	}

	public void setEndPrintNo(String endPrintNo) {
		this.endPrintNo = endPrintNo;
	}

	public int getPrintType() {
		return printType;
	}

	public void setPrintType(int printType) {
		this.printType = printType;
	}

	public int getPrintFlag() {
		return printFlag;
	}

	public void setPrintFlag(int printFlag) {
		this.printFlag = printFlag;
	}


}
