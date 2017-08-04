package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
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
public class S8248QueryRedReasonOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5157144857260352891L;

	@JSONField(name = "REASON_LIST")
	@ParamDesc(path = "REASON_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "冲红原因配置", memo = "略")
	private List<PubCodeDictEntity> reasonList = new ArrayList<PubCodeDictEntity>();

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("reasonList"), reasonList);
		return result;
	}

	public List<PubCodeDictEntity> getReasonList() {
		return reasonList;
	}

	public void setReasonList(List<PubCodeDictEntity> reasonList) {
		this.reasonList = reasonList;
	}

}
