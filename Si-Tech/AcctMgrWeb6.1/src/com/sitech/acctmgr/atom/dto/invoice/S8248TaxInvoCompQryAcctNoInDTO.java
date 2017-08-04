package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
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
public class S8248TaxInvoCompQryAcctNoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3913157713438810154L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号", memo = "略")
	private String phoneNo;
	@ParamDesc(path = "BUSI_INFO.ID_ICCID", cons = ConsType.QUES, type = "String", len = "20", desc = "身份证号", memo = "略")
	private String idIccid;
	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.CT001, type = "int", len = "1", desc = "身份证号", memo = "0:服务号码查询,1:身份证查询,2:账户直接查询")
	private int qryType;
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号", memo = "略")
	private long contractNo;
	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.QUES, type = "long", len = "20", desc = "开始年月", memo = "略")
	private int beginYm;
	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.QUES, type = "long", len = "20", desc = "结束年月", memo = "略")
	private int endYm;

	@ParamDesc(path = "BUSI_INFO.TAX_PAYER_ID", cons = ConsType.CT001, type = "String", len = "20", desc = "纳税人识别号", memo = "略")
	private String taxPayerId;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		log.debug("arg0:::::::" + arg0);
		beginYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginYm")));
		endYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("endYm")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("taxPayerId")))) {
			taxPayerId = arg0.getStr(getPathByProperName("taxPayerId"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idIccid")))) {
			idIccid = arg0.getStr(getPathByProperName("idIccid"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("qryType")))) {
			qryType = Integer.parseInt(arg0.getStr(getPathByProperName("qryType")));
		}

	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getIdIccid() {
		return idIccid;
	}

	public void setIdIccid(String idIccid) {
		this.idIccid = idIccid;
	}

	public int getQryType() {
		return qryType;
	}

	public void setQryType(int qryType) {
		this.qryType = qryType;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
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

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

}
