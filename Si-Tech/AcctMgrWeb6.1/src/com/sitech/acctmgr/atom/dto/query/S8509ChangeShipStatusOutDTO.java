package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 修改亲情网提醒状态出参DTO
 * </p>
 * <p>
 * Description: 修改亲情网提醒状态出参DTO，封装出参情况
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
public class S8509ChangeShipStatusOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		log.info(result.toString());
		return result;
	}

}
