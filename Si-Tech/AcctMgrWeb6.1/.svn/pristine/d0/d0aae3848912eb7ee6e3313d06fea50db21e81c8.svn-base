package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
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
 * @author liuhl_bj
 * @version 1.0
 */
public class S8412QryBillInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4076032478943349501L;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "账号号码", memo = "略")
	private long contractNo = 0;
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "long", len = "18", desc = "用户ID", memo = "可空")
	private long idNo = 0;
	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "开始时间", memo = "可空")
	private int beginTime = 0;
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "结束时间", memo = "可空")
	private int endTime = 0;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))) {
			idNo = Long.valueOf(arg0.getStr(getPathByProperName("idNo")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginTime")))) {
			beginTime = Integer.valueOf(arg0.getStr(getPathByProperName("beginTime")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endTime")))) {
			endTime = Integer.valueOf(arg0.getStr(getPathByProperName("endTime")));
		}
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public int getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(int beginTime) {
		this.beginTime = beginTime;
	}

	public int getEndTime() {
		return endTime;
	}

	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}

}
