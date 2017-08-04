package com.sitech.acctmgr.atom.dto.invoice;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.invoice.InvCondEntity;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoEntity;
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
public class S8248subConCfmInvInDTO extends CommonInDTO {

	private static final long serialVersionUID = -885038541670527959L;

	// 账号列表
	@ParamDesc(path = "BUSI_INFO.ACCT_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "账户列表", memo = "略")
	private List<InvCondEntity> acctList;

	// 手机号
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号", memo = "略")
	private String phoneNo;
	// 税率
	@ParamDesc(path = "BUSI_INFO.TAX_RATE", cons = ConsType.CT001, type = "double", len = "10", desc = "税率", memo = "略")
	private double taxRate;

	// 发票流程状态
	@ParamDesc(path = "BUSI_INFO.STATE", cons = ConsType.CT001, type = "String", len = "3", desc = "发票流程状态", memo = "略")
	private String state;

	// 发票状态
	@ParamDesc(path = "BUSI_INFO.INV_TYPE", cons = ConsType.CT001, type = "String", len = "3", desc = "发票状态", memo = "略")
	private String invType;

	// 审批工号
	@ParamDesc(path = "BUSI_INFO.REPORT_TO", cons = ConsType.CT001, type = "String", len = "20", desc = "审批工号", memo = "略")
	private String reportTo;

	// 客户ID
	@ParamDesc(path = "BUSI_INFO.CUST_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "客户ID", memo = "略")
	private long custId;

	// TAXPAYER_ID
	@ParamDesc(path = "BUSI_INFO.TAXPAYER_ID", cons = ConsType.CT001, type = "long", len = "30", desc = "集团增值税资质号", memo = "略")
	private String taxPayerId;

	// 申请发票信息
	@ParamDesc(path = "BUSI_INFO.TAXINVO_INFO", cons = ConsType.PLUS, type = "compx", len = "1", desc = "申请发票信息", memo = "略")
	private List<TaxInvoEntity> taxInvoInfo = new ArrayList<TaxInvoEntity>();

	@ParamDesc(path = "BUSI_INFO.UNIT_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String unitName;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账户号", memo = "略")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.DATA_SOURCE", cons = ConsType.CT001, type = "String", len = "20", desc = "所在域", memo = "略")
	private String dataSource;

	@ParamDesc(path = "BUSI_INFO.REDINV_CAUSE", cons = ConsType.CT001, type = "String", len = "10", desc = "红色发票原因选项", memo = "略")
	private String redinvCause;

	@ParamDesc(path = "BUSI_INFO.REDINV_ORDERNO ", cons = ConsType.CT001, type = "String", len = "200", desc = "红色发票通知单号", memo = "略")
	private String redinvOrderNo;

	@ParamDesc(path = "BUSI_INFO.REDINV_REMARK ", cons = ConsType.CT001, type = "String", len = "200", desc = "红票申请原因字段", memo = "略")
	private String redinvRemark;

	@ParamDesc(path = "BUSI_INFO.REDINV_CRMREMARK", cons = ConsType.CT001, type = "String", len = "200", desc = "CRM备注字段", memo = "略")
	private String redinvCrmRemark;

	@ParamDesc(path = "BUSI_INFO.ORDER_SN_REL", cons = ConsType.CT001, type = "long", len = "14", desc = "审批单关联的外部流水", memo = "略")
	private long ordersnRel;

	public List<InvCondEntity> getAcctList() {
		return acctList;
	}

	public void setAcctList(List<InvCondEntity> acctList) {
		this.acctList = acctList;
	}

	public long getOrdersnRel() {
		return ordersnRel;
	}

	public void setOrdersnRel(long ordersnRel) {
		this.ordersnRel = ordersnRel;
	}

	public String getRedinvCause() {
		return redinvCause;
	}

	public void setRedinvCause(String redinvCause) {
		this.redinvCause = redinvCause;
	}

	public String getRedinvOrderNo() {
		return redinvOrderNo;
	}

	public void setRedinvOrderNo(String redinvOrderNo) {
		this.redinvOrderNo = redinvOrderNo;
	}

	public String getRedinvRemark() {
		return redinvRemark;
	}

	public void setRedinvRemark(String redinvRemark) {
		this.redinvRemark = redinvRemark;
	}

	public String getRedinvCrmRemark() {
		return redinvCrmRemark;
	}

	public void setRedinvCrmRemark(String redinvCrmRemark) {
		this.redinvCrmRemark = redinvCrmRemark;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
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

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public String getReportTo() {
		return reportTo;
	}

	public void setReportTo(String reportTo) {
		this.reportTo = reportTo;
	}

	public long getCustId() {
		return custId;
	}

	public void setCustId(long custId) {
		this.custId = custId;
	}

	public List<TaxInvoEntity> getTaxInvoInfo() {
		return taxInvoInfo;
	}

	public void setTaxInvoInfo(List<TaxInvoEntity> taxInvoInfo) {
		this.taxInvoInfo = taxInvoInfo;
	}

	public double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		log.info("arg0=" + arg0.toString());
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		} else {
			throw new BusiException(getErrorCode("8248", "00103"), "手机号不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		} else {
			throw new BusiException(getErrorCode("8248", "00104"), "账号不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("dataSource")))) {
			dataSource = arg0.getStr(getPathByProperName("dataSource"));
		} else {
			throw new BusiException(getErrorCode("8248", "00105"), "所在域名不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reportTo")))) {
			reportTo = arg0.getStr(getPathByProperName("reportTo"));
		} else {
			throw new BusiException(getErrorCode("8248", "01016"), "审批工号不可为空!");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reportTo")))) {
			reportTo = arg0.getStr(getPathByProperName("reportTo"));
		} else {
			throw new BusiException(getErrorCode("8248", "01017"), "审批工号不可为空!");
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("custId")))
				&& StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("taxPayerId")))
				&& StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("unitName")))) {

			custId = ValueUtils.longValue(arg0.getStr(getPathByProperName("custId")));
			taxPayerId = arg0.getStr(getPathByProperName("taxPayerId"));
			unitName = arg0.getStr(getPathByProperName("unitName"));
		} else {
			throw new BusiException(getErrorCode("8248", "01018"), "集团客户资质信息不可为空!");
		}

		if (arg0.getList(getPathByProperName("taxInvoInfo")) == null || arg0.getList(getPathByProperName("taxInvoInfo")).size() == 0) {
			// 弹错，月份列表不能为空
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01019"), "申请发票数据不能为空！");
		} else {
			List<Map<String, Object>> backListTmp = (List<Map<String, Object>>) arg0.getList(getPathByProperName("taxInvoInfo"));
			for (Map<String, Object> map : backListTmp) {
				String jsonBack = JSON.toJSONString(map);
				this.taxInvoInfo.add(JSON.parseObject(jsonBack, TaxInvoEntity.class));
			}
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvCause")))) {
			redinvCause = arg0.getStr(getPathByProperName("redinvCause"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvOrderNo")))) {
			redinvOrderNo = arg0.getStr(getPathByProperName("redinvOrderNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvRemark")))) {
			redinvRemark = arg0.getStr(getPathByProperName("redinvRemark"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvCrmRemark")))) {
			redinvCrmRemark = arg0.getStr(getPathByProperName("redinvCrmRemark"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("ordersnRel")))) {
			ordersnRel = ValueUtils.longValue(arg0.getStr(getPathByProperName("ordersnRel")));
		}

		if (arg0.getList(getPathByProperName("acctList")) != null && arg0.getList(getPathByProperName("acctList")).size() > 0) {
			acctList = new ArrayList<InvCondEntity>();
			for (Map<String, Object> invConMap : arg0.getList(getPathByProperName("acctList"), Map.class)) {
				String jsonStr = JSON.toJSONString(invConMap);
				acctList.add(JSON.parseObject(jsonStr, InvCondEntity.class));
			}
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01003"), "发票账号集合不能为空！");
		}

	}
}
