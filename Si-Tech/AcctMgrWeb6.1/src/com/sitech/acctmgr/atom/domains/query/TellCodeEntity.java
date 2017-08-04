package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class TellCodeEntity {
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="手机号码",memo="略")
	private String phoneNo = "";
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="40",desc="归属地",memo="略")
	private String regionName = "";
	@JSONField(name="ORDER_FLAG")
	@ParamDesc(path="ORDER_FLAG",cons=ConsType.CT001,type="String",len="40",desc="计费类型",memo="略")
	private String orderFlag = "";
	@JSONField(name="ZY_FLAG")
	@ParamDesc(path="ZY_FLAG",cons=ConsType.CT001,type="String",len="40",desc="业务分类",memo="略")
	private String zyFlag = "";
	@JSONField(name="SERV_NAME")
	@ParamDesc(path="SERV_NAME",cons=ConsType.CT001,type="String",len="300",desc="业务名称",memo="略")
	private String servName = "";
	@JSONField(name="OPER_CODE")
	@ParamDesc(path="OPER_CODE",cons=ConsType.CT001,type="String",len="20",desc="业务代码",memo="略")
	private String operCode = "";
	@JSONField(name="FEE")
	@ParamDesc(path="FEE",cons=ConsType.CT001,type="String",len="10",desc="资费标准",memo="略")
	private String fee = "";
	@JSONField(name="REPLY_TIME")
	@ParamDesc(path="REPLY_TIME",cons=ConsType.CT001,type="String",len="14",desc="客户回复信息时间",memo="略")
	private String replyTime = "";
	@JSONField(name="REPLY_TIME1")
	@ParamDesc(path="REPLY_TIME1",cons=ConsType.CT001,type="String",len="14",desc="系统回复客户时间",memo="略")
	private String replyTime1 = "";
	@JSONField(name="FLAG")
	@ParamDesc(path="FLAG",cons=ConsType.CT001,type="String",len="10",desc="是否减免费用",memo="略")
	private String flag = "";
	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}
	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}
	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	/**
	 * @return the orderFlag
	 */
	public String getOrderFlag() {
		return orderFlag;
	}
	/**
	 * @param orderFlag the orderFlag to set
	 */
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}
	/**
	 * @return the zyFlag
	 */
	public String getZyFlag() {
		return zyFlag;
	}
	/**
	 * @param zyFlag the zyFlag to set
	 */
	public void setZyFlag(String zyFlag) {
		this.zyFlag = zyFlag;
	}
	/**
	 * @return the servName
	 */
	public String getServName() {
		return servName;
	}
	/**
	 * @param servName the servName to set
	 */
	public void setServName(String servName) {
		this.servName = servName;
	}
	/**
	 * @return the operCode
	 */
	public String getOperCode() {
		return operCode;
	}
	/**
	 * @param operCode the operCode to set
	 */
	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}

	/**
	 * @return the replyTime
	 */
	public String getReplyTime() {
		return replyTime;
	}
	/**
	 * @param replyTime the replyTime to set
	 */
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}
	/**
	 * @return the replyTime1
	 */
	public String getReplyTime1() {
		return replyTime1;
	}
	/**
	 * @param replyTime1 the replyTime1 to set
	 */
	public void setReplyTime1(String replyTime1) {
		this.replyTime1 = replyTime1;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/**
	 * @return the fee
	 */
	public String getFee() {
		return fee;
	}
	/**
	 * @param fee the fee to set
	 */
	public void setFee(String fee) {
		this.fee = fee;
	}
}
