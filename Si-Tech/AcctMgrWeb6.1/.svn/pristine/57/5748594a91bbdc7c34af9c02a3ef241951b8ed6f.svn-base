package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.GprsChangeRecdEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询GPRS流量提醒变更出参DTO
 * </p>
 * <p>
 * Description: 查询GPRS流量提醒变更出参DTO，封装出参情况
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
public class S8509OperRecdOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "OPER_RECD_LIST", cons = ConsType.QUES, type = "compx", len = "", desc = "操作记录列表", memo = "")
	private List<GprsChangeRecdEntity> operRecdList;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("operRecdList"), operRecdList);
		log.info(result.toString());
		return result;
	}

	public List<GprsChangeRecdEntity> getOperRecdList() {
		return operRecdList;
	}

	public void setOperRecdList(List<GprsChangeRecdEntity> operRecdList) {
		this.operRecdList = operRecdList;
	}

}
