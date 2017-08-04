package com.sitech.acctmgr.atom.dto.feeqry;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.EchgCardRdInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

public class SEchargeCardOutDTO extends CommonOutDTO {    
	private static final long serialVersionUID = 1L;

	@JSONField(name = "RECD_LIST")
	@ParamDesc(path = "RECD_LIST", cons = ConsType.QUES, type = "complex", len = "", desc = "有价卡充值记录", memo = "略")
	List<EchgCardRdInfoEntity> outList = new ArrayList<EchgCardRdInfoEntity>();

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "string", len = "40", desc = "查询服务号码", memo = "略")
	String phoneNo;
	
	@JSONField(name = "BELONG_NAME")
	@ParamDesc(path = "BELONG_NAME", cons = ConsType.CT001, type = "string", len = "40", desc = "用户归属地市", memo = "略")
	String belongName;
	
	@JSONField(name = "PAY_CHANNEL")
	@ParamDesc(path = "PAY_CHANNEL", cons = ConsType.CT001, type = "string", len = "2", desc = "渠道类型", memo = "略")
	String payChannel;
	
	@JSONField(name = "SUM_TYPE")
	@ParamDesc(path = "SUM_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "类型", memo = "略")
	String sumType;
	
	@JSONField(name = "REMARK")
	@ParamDesc(path = "REMARK", cons = ConsType.CT001, type = "string", len = "60", desc = "备注", memo = "略")
	String remark;

	@Override
	public MBean encode() {
		// TODO Auto-generated method stub

		MBean result = super.encode();
		result.setRoot(getPathByProperName("outList"), outList);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("belongName"), belongName);
		result.setRoot(getPathByProperName("payChannel"), payChannel);
		result.setRoot(getPathByProperName("sumType"), sumType);
		result.setRoot(getPathByProperName("remark"), remark);
		
		return result;
	}

	public List<EchgCardRdInfoEntity> getOutList() {
		return outList;
	}

	public void setOutList(List<EchgCardRdInfoEntity> outList) {
		this.outList = outList;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBelongName() {
		return belongName;
	}

	public void setBelongName(String belongName) {
		this.belongName = belongName;
	}

	public String getPayChannel() {
		return payChannel;
	}

	public void setPayChannel(String payChannel) {
		this.payChannel = payChannel;
	}

	public String getSumType() {
		return sumType;
	}

	public void setSumType(String sumType) {
		this.sumType = sumType;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
