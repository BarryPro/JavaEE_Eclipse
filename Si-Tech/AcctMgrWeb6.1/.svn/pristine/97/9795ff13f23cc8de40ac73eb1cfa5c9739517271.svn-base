package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：打印发票
 * 
 * @author liuhl_bj
 *
 */
public class SPreInvoicePrintInDTO extends CommonInDTO {

	private static final long serialVersionUID = 2437286863730547360L;

	@ParamDesc(path = "BUSI_INFO.PAY_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "缴费流水", memo = "略")
	private long paySn;

	@ParamDesc(path = "BUSI_INFO.FOREIGN_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "外部流水", memo = "略")
	private String foreignSn;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "3", desc = "账户号码", memo = "")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.TOTAL_DATE", cons = ConsType.CT001, type = "string", len = "3", desc = "缴费日期", memo = "")
	private int totalDate;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "string", len = "3", desc = "发票号码", memo = "")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "string", len = "3", desc = "发票代码", memo = "")
	private String invCode;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("paySn")))) {
			paySn = ValueUtils.longValue(arg0.getStr(getPathByProperName("paySn")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("foreignSn")))) {
			foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		}
		invCode = arg0.getStr(getPathByProperName("invCode"));
		invNo = arg0.getStr(getPathByProperName("invNo"));
		totalDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("totalDate")));
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	public String getForeignSn() {
		return foreignSn;
	}

	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
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

}
