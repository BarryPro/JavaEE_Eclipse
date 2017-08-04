package com.sitech.acctmgr.atom.dto.invoice;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import java.util.List;

import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
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
public class S8248BOSSCfmInDTO extends CommonInDTO {

	private static final long serialVersionUID = -885038541670527959L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "账户号码", memo = "略")
	private String contractNo;

	@ParamDesc(path = "BUSI_INFO.ORDER_SN", cons = ConsType.QUES, type = "String", len = "20", desc = "订单流水", memo = "主要记录CRM的流水信息，BOSS侧不传，默认为审核流水")
	private String orderSn;

	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.QUES, type = "String", len = "20", desc = "查询类型", memo = "查询类型   2：一点支付")
	private int qryType;

	@ParamDesc(path = "BUSI_INFO.DATA_SOURCE", cons = ConsType.CT001, type = "String", len = "20", desc = "域", memo = "1：BOSS   2：CRM")
	private String dataSource;

	@ParamDesc(path = "BUSI_INFO.REPORT_TO", cons = ConsType.CT001, type = "String", len = "20", desc = "开具人", memo = "即下一个审批人")
	private String reportTo;

	@ParamDesc(path = "BUSI_INFO.AUDIT_PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "审核人的手机号", memo = "用于发送短信")
	private String auditPhoneNo;

	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.QUES, type = "String", len = "20", desc = "备注", memo = "发票备注栏的信息")
	private String remark;

	@ParamDesc(path = "BUSI_INFO.TAX_INVOICEFEE_LIST", cons = ConsType.PLUS, type = "compx", len = "200", desc = "发票上展示的费用信息", memo = "略")
	private List<TaxInvoiceFeeEntity> taxInvoiceFeeList;

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "string", len = "200", desc = "发票上展示的费用信息", memo = "略")
	private int beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "string", len = "200", desc = "发票上展示的费用信息", memo = "略")
	private int endYm;

	@ParamDesc(path = "BUSI_INFO.INV_TYPE", cons = ConsType.CT001, type = "int", len = "200", desc = "发票类型", memo = "0：普通发票   1：红字发票   2：增值税发票作废")
	private int invType;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, type = "int", len = "200", desc = "标志", memo = "0：普通  1：预开")
	private int flag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		log.info("arg0=" + arg0.toString());
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = arg0.getStr(getPathByProperName("contractNo"));
		} else {
			throw new BusiException(getErrorCode("8248", "00010"), "账号不可为空!");
		}

		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("orderSn")))) {
			orderSn = arg0.getStr(getPathByProperName("orderSn"));
		}

		dataSource = arg0.getStr(getPathByProperName("dataSource"));

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reportTo")))) {
			reportTo = arg0.getStr(getPathByProperName("reportTo"));
		} else {
			throw new BusiException(getErrorCode("8248", "00012"), "审批工号不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("auditPhoneNo")))) {
			auditPhoneNo = arg0.getStr(getPathByProperName("auditPhoneNo"));
		} else {
			throw new BusiException(getErrorCode("8248", "00014"), "审批人手机号不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("remark")))) {
			remark = arg0.getStr(getPathByProperName("remark"));
		}

		beginYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginYm")));
		endYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("endYm")));
		taxInvoiceFeeList = arg0.getList(getPathByProperName("taxInvoiceFeeList"), TaxInvoiceFeeEntity.class);
		invType = ValueUtils.intValue(arg0.getStr(getPathByProperName("invType")));
		qryType = ValueUtils.intValue(arg0.getStr(getPathByProperName("qryType")));
		flag = ValueUtils.intValue(arg0.getStr(getPathByProperName("flag")));
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getInvType() {
		return invType;
	}

	public void setInvType(int invType) {
		this.invType = invType;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getOrderSn() {
		return orderSn;
	}

	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getReportTo() {
		return reportTo;
	}

	public void setReportTo(String reportTo) {
		this.reportTo = reportTo;
	}

	public String getAuditPhoneNo() {
		return auditPhoneNo;
	}

	public void setAuditPhoneNo(String auditPhoneNo) {
		this.auditPhoneNo = auditPhoneNo;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<TaxInvoiceFeeEntity> getTaxInvoiceFeeList() {
		return taxInvoiceFeeList;
	}

	public void setTaxInvoiceFeeList(List<TaxInvoiceFeeEntity> taxInvoiceFeeList) {
		this.taxInvoiceFeeList = taxInvoiceFeeList;
	}

	public int getBeginYm() {
		return beginYm;
	}

	public void setBeginYm(int beginYm) {
		this.beginYm = beginYm;
	}

	public int getEndYm() {
		return endYm;
	}

	public void setEndYm(int endYm) {
		this.endYm = endYm;
	}

	public int getQryType() {
		return qryType;
	}

	public void setQryType(int qryType) {
		this.qryType = qryType;
	}

}
