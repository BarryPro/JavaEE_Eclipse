package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
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
public class S8215PrintInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3519587427565546052L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号", memo = "略")
	protected String phoneNo;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账户号", memo = "略")
	protected long contractNo;

	@ParamDesc(path = "BUSI_INFO.UNIT_NAME", cons = ConsType.CT001, type = "long", len = "20", desc = "集团名称", memo = "略")
	private String unitName;

	@ParamDesc(path = "BUSI_INFO.CHECK_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "支票号", memo = "略")
	private String checkNo;

	@ParamDesc(path = "BUSI_INFO.ITEM1", cons = ConsType.CT001, type = "long", len = "20", desc = "项目1", memo = "略")
	private String item1;

	@ParamDesc(path = "BUSI_INFO.ITEM2", cons = ConsType.CT001, type = "long", len = "20", desc = "项目2", memo = "略")
	private String item2;

	@ParamDesc(path = "BUSI_INFO.ITEM3", cons = ConsType.CT001, type = "long", len = "20", desc = "项目3", memo = "略")
	private String item3;

	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.CT001, type = "long", len = "20", desc = "备注", memo = "略")
	private String remark;

	@ParamDesc(path = "BUSI_INFO.PRINT_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "打印类型", memo = "0:分月打印,1:合并打印")
	protected String printType;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票号", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.PRINT_FEE", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票金额", memo = "略")
	private long printFee;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("unitName")))) {
			unitName = arg0.getStr(getPathByProperName("unitName"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("remark")))) {
			remark = arg0.getStr(getPathByProperName("remark"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("checkNo")))) {
			checkNo = arg0.getStr(getPathByProperName("checkNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("item1")))) {
			item1 = arg0.getStr(getPathByProperName("item1"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("item2")))) {
			item2 = arg0.getStr(getPathByProperName("item2"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("item3")))) {
			item3 = arg0.getStr(getPathByProperName("item3"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}
		if (contractNo == 0 && StringUtils.isEmptyOrNull(phoneNo)) {
			throw new BusiException(AcctMgrError.getErrorCode("8215", "01002"), "移动台号和协议号码不能同时为空");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("printType")))) {
			printType = arg0.getStr(getPathByProperName("printType"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("printFee")))) {
			printFee = ValueUtils.longValue(arg0.getStr(getPathByProperName("printFee")));
		}

		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invNo"))) && StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invCode")))) {
			invNo = arg0.getStr(getPathByProperName("invNo"));
			invCode = arg0.getStr(getPathByProperName("invCode"));
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8000", "01009"), "发票号或者发票代码传入空！");
		}

	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getItem1() {
		return item1;
	}

	public void setItem1(String item1) {
		this.item1 = item1;
	}

	public String getItem2() {
		return item2;
	}

	public void setItem2(String item2) {
		this.item2 = item2;
	}

	public String getItem3() {
		return item3;
	}

	public void setItem3(String item3) {
		this.item3 = item3;
	}

	public String getPrintType() {
		return printType;
	}

	public void setPrintType(String printType) {
		this.printType = printType;
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

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

}
