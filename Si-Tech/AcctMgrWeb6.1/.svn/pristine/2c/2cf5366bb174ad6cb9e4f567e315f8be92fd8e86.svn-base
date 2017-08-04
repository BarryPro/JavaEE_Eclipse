package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询GPRS流量提醒状态和亲情网提醒状态出参DTO
 * </p>
 * <p>
 * Description: 查询GPRS流量提醒状态和亲情网提醒状态出参DTO，封装出参情况
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
public class S8509QryStatusOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "GRPS_STATUS", cons = ConsType.CT001, type = "String", len = "1", desc = "GPRS流量提醒状态", memo = "0：开通，1：关闭")
	private String GPRSStatus;

	@ParamDesc(path = "SHIP_STATUS", cons = ConsType.CT001, type = "string", len = "1", desc = "亲情网提醒状态", memo = "0：开通，1：关闭")
	private String shipStatus;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("GPRSStatus"), GPRSStatus);
		result.setRoot(getPathByProperName("shipStatus"), shipStatus);
		log.info(result.toString());
		return result;
	}

	public String getGPRSStatus() {
		return GPRSStatus;
	}

	public void setGPRSStatus(String gPRSStatus) {
		GPRSStatus = gPRSStatus;
	}

	public String getShipStatus() {
		return shipStatus;
	}

	public void setShipStatus(String shipStatus) {
		this.shipStatus = shipStatus;
	}

}
