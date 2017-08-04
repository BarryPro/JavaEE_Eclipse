package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 飞豆充值验证出参DTO  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public class SFeiDouPayCheckOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8980369576766992841L;

	@JSONField(name="OPT_SEQ")
	@ParamDesc(path="OPT_SEQ",cons=ConsType.CT001,type="String",len="32",desc="操作流水",memo="略")
	String optSeq;
	
	@JSONField(name="SYSPLAT_ID")
	@ParamDesc(path="SYSPLAT_ID",cons=ConsType.CT001,type="String",len="4",desc="平台标识号",memo="略")
	String sysplatId;

	@JSONField(name="PAY_ACCID")
	@ParamDesc(path="PAY_ACCID",cons=ConsType.CT001,type="long",len="20",desc="支付帐户标识",memo="略")
	long payAccid;
	
	@JSONField(name="SERV_ID")
	@ParamDesc(path="SERV_ID",cons=ConsType.CT001,type="long",len="20",desc="用户标识",memo="略")
	long servId;
	
	@JSONField(name="REQ_DATE")
	@ParamDesc(path="REQ_DATE",cons=ConsType.CT001,type="Sting",len="14",desc="请求时间",memo="格式：YYYYMMDDHH24MISS")
	String reqDate;

	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("optSeq"), optSeq);
		result.setRoot(getPathByProperName("sysplatId"), sysplatId);
		result.setRoot(getPathByProperName("payAccid"), payAccid);
		result.setRoot(getPathByProperName("reqDate"), reqDate);
		return result;
	}

	public String getOptSeq() {
		return optSeq;
	}

	public void setOptSeq(String optSeq) {
		this.optSeq = optSeq;
	}

	public String getSysplatId() {
		return sysplatId;
	}

	public void setSysplatId(String sysplatId) {
		this.sysplatId = sysplatId;
	}

	public long getPayAccid() {
		return payAccid;
	}

	public void setPayAccid(long payAccid) {
		this.payAccid = payAccid;
	}

	public long getServId() {
		return servId;
	}

	public void setServId(long servId) {
		this.servId = servId;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

}
