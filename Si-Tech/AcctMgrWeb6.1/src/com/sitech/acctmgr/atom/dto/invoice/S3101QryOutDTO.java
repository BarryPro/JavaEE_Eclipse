package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.PayInfoEntity;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.out.OutDTO;

public class S3101QryOutDTO extends OutDTO {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "PAY_INFO_LIST")
	@ParamDesc(path = "PAY_INFO_LIST", cons = ConsType.PLUS, type = "compx", len = "10", desc = "缴费信息", memo = "略")
	private List<PayInfoEntity> payInfoList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("payInfoList"), payInfoList);
		return result;
	}

	public List<PayInfoEntity> getPayInfoList() {
		return payInfoList;
	}

	public void setPayInfoList(List<PayInfoEntity> payInfoList) {
		this.payInfoList = payInfoList;
	}

}
