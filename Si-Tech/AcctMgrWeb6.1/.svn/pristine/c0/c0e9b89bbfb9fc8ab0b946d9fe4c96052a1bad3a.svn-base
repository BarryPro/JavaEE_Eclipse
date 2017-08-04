package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */ 
public class PayIntEntity implements Serializable {
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="30",desc="操作时间",memo="略")
	private String opTime = "";
	@JSONField(name = "PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="20",desc="交费金额",memo="单位:分")
	private String payMoney = "";
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="50",desc="操作工号",memo="略")
	private String loginNo = "";
	@JSONField(name = "GROUP_NAME")
	@ParamDesc(path="GROUP_NAME",cons=ConsType.CT001,type="String",len="100",desc="地市归属名称",memo="略")
	private String groupName = "";
	@JSONField(name = "PAYPATH_NAME")
	@ParamDesc(path="PAYPATH_NAME",cons=ConsType.CT001,type="String",len="100",desc="渠道名称",memo="略")
	private String paypathName = "";
	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="10",desc="交费方式",memo="略")
	private String payType = "";
	@JSONField(name = "PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="100",desc="交费方式名称",memo="略")
	private String payTypeName = "";
	
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="String",len="100",desc="充值订单号",memo="略")
	private String paySn = "";
	
	@ParamDesc(path="NOTE",cons=ConsType.CT001,type="String",len="1000",desc="备注",memo="客户在各缴费渠道中参加的活动名称")
	private String note = "";
	
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getPaySn() {
		return paySn;
	}
	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}
	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}
	/**
	 * @return the paypathName
	 */
	public String getPaypathName() {
		return paypathName;
	}
	/**
	 * @param paypathName the paypathName to set
	 */
	public void setPaypathName(String paypathName) {
		this.paypathName = paypathName;
	}
	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}
	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
	/**
	 * @return the payMoney
	 */
	public String getPayMoney() {
		return payMoney;
	}
	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}
	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}
	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}
	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}
	/**
	 * @return the payTypeName
	 */
	public String getPayTypeName() {
		return payTypeName;
	}
	/**
	 * @param payTypeName the payTypeName to set
	 */
	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}
	
	
}
