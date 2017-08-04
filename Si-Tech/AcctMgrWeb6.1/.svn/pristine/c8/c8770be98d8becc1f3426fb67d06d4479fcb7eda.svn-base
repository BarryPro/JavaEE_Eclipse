package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.GrpOweEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 集团欠费信息出参DTO
 * </p>
 * <p>
 * Description: 集团欠费信息出参DTO，封装出参情况
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
public class S8177OutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "BILL_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "账单列表", memo = "略")
	private List<GrpOweEntity> billList = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("billList"), billList);
		log.info(result.toString());
		return result;
	}

	public List<GrpOweEntity> getBillList() {
		return billList;
	}

	public void setBillList(List<GrpOweEntity> billList) {
		this.billList = billList;
	}

}
