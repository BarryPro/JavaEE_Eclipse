package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.AdjOweEntity;
import com.sitech.acctmgr.atom.domains.record.RefundLoginEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8124RefundInitOutDTO extends CommonOutDTO{

	@JSONField(name="REFUNDINFO")
	@ParamDesc(path="REFUNDINFO",cons=ConsType.STAR,type="compx",len="1",desc="退费备注信息列表",memo="略")
	private List<RefundLoginEntity> refundInfo = new ArrayList<RefundLoginEntity>();	
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("refundInfo"), refundInfo);
		return result;
	}

	/**
	 * @return the refundInfo
	 */
	public List<RefundLoginEntity> getRefundInfo() {
		return refundInfo;
	}

	/**
	 * @param refundInfo the refundInfo to set
	 */
	public void setRefundInfo(List<RefundLoginEntity> refundInfo) {
		this.refundInfo = refundInfo;
	}
	
}
