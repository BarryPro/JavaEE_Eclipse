package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class RefundEntity {

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", type = "String", desc = "服务号码", memo = "")
	private String phoneNo;

	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, len = "40", type = "String", desc = "用户ID", memo = "")
	private long idNo;

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, len = "18", type = "long", desc = "操作流水", memo = "")
	private long loginAccept;

	@JSONField(name = "OP_TYPE_NAME")
	@ParamDesc(path = "OP_TYPE_NAME", cons = ConsType.CT001, len = "18", type = "string", desc = "业务名称", memo = "")
	private String opTypeName;

	@JSONField(name = "BEGIN_TIME")
	@ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, len = "18", type = "String", desc = "退费开始时间", memo = "")
	private String beginTime;

	@JSONField(name = "END_TIME")
	@ParamDesc(path = "END_TIME", cons = ConsType.CT001, type = "String", len = "8", desc = "退费结束时间", memo = "略")
	private String endTime;

	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "String", len = "8", desc = "操作时间", memo = "略")
	private String opTime = "";

	@JSONField(name = "FOREIGN_ACCEPT")
	@ParamDesc(path = "FOREIGN_ACCEPT", cons = ConsType.CT001, type = "String", len = "5", desc = "外部流水", memo = "略")
	private String foreignAccept = "";

	@JSONField(name = "REFUND_TYPE")
	@ParamDesc(path = "REFUND_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "00：单倍退预存 01：双倍退预存 02：双倍退预存退现金", memo = "略")
	private String refundType = "";

	@JSONField(name = "REFUND_TYPE_NAME")
	@ParamDesc(path = "REFUND_TYPE_NAME", cons = ConsType.CT001, type = "String", len = "1", desc = "00：单倍退预存 01：双倍退预存 02：双倍退预存退现金", memo = "略")
	private String refundTypeName = "";

	@JSONField(name = "REFUND_MONEY")
	@ParamDesc(path = "REFUND_MONEY", cons = ConsType.CT001, type = "long", len = "10", desc = "退费金额", memo = "略")
	private long refundMoney = 0;

	@JSONField(name = "SP_CODE")
	@ParamDesc(path = "SP_CODE", cons = ConsType.CT001, type = "string", len = "10", desc = "sp代码", memo = "略")
	private String spCode = "无";

	@JSONField(name = "OPER_CODE")
	@ParamDesc(path = "OPER_CDDE", cons = ConsType.CT001, type = "string", len = "10", desc = "企业代码", memo = "略")
	private String operCode = "无";

	@JSONField(name = "SP_NAME")
	@ParamDesc(path = "SP_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "sp名称", memo = "略")
	private String spName = "无";

	@JSONField(name = "OPER_NAME")
	@ParamDesc(path = "OPER_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "企业名称", memo = "略")
	private String operName = "";

	@JSONField(name = "BILL_TYPE")
	@ParamDesc(path = "BILL_TYPE", cons = ConsType.CT001, type = "string", len = "10", desc = "计费类型代码", memo = "略")
	private String billType = "无";

	@JSONField(name = "BILL_NAME")
	@ParamDesc(path = "BILL_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "计费类型", memo = "略")
	private String billName = "无";

	@JSONField(name = "REGION_NAME")
	@ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "服务号码所在地市", memo = "略")
	private String regionName;

	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, type = "string", len = "10", desc = "工号", memo = "略")
	private String loginNo;

	@JSONField(name = "REASON_CODE")
	@ParamDesc(path = "REASON_CODE", cons = ConsType.CT001, type = "string", len = "10", desc = "三级原因代码", memo = "略")
	private String reasonCode;

	@JSONField(name = "REASON_NAME")
	@ParamDesc(path = "REASON_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "三级原因名称", memo = "略")
	private String reasonName;
	
	@JSONField(name = "LAST_TIME")
	@ParamDesc(path = "LAST_TIME", cons = ConsType.CT001, type = "String", len = "8", desc = "业务使用时间", memo = "略")
	private String lastTime = "";
	
	@JSONField(name = "CHECK_TIME")
	@ParamDesc(path = "CHECK_TIME", cons = ConsType.CT001, type = "String", len = "8", desc = "核减时间", memo = "略")
	private String checkTime = "";

	@JSONField(name = "STATUS")
	@ParamDesc(path = "STATUS", cons = ConsType.CT001, type = "String", len = "2", desc = "状态标识", memo = "略")
	private String status = "";
	
	@JSONField(name = "UNIT_PRICE")
	@ParamDesc(path = "UNIT_PRICE", cons = ConsType.CT001, type = "String", len = "8", desc = "单价", memo = "略")
	private String unitPrice = "";
	
	@JSONField(name = "QUANTITY")
	@ParamDesc(path = "QUANTITY", cons = ConsType.CT001, type = "String", len = "8", desc = "数量", memo = "略")
	private String quantity = "";
	
	@JSONField(name = "FLAG")
	@ParamDesc(path = "FLAG", cons = ConsType.CT001, type = "String", len = "3", desc = "ivr标识", memo = "略")
	private String ivrFlag = "";
	
	@JSONField(name = "RETURN_TYPE")
	@ParamDesc(path = "RETURN_TYPE", cons = ConsType.CT001, type = "String", len = "8", desc = "数量", memo = "略")
	private String returnType = "";
	
	@JSONField(name = "CHECK_TYPE")
	@ParamDesc(path = "CHECK_TYPE", cons = ConsType.CT001, type = "String", len = "8", desc = "数量", memo = "略")
	private String checkType = "";
	
	
	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public String getReturnType() {
		return returnType;
	}

	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}

	public String getIvrFlag() {
		return ivrFlag;
	}

	public void setIvrFlag(String ivrFlag) {
		this.ivrFlag = ivrFlag;
	}

	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}



	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

	public String getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReasonCode() {
		return reasonCode;
	}

	public void setReasonCode(String reasonCode) {
		this.reasonCode = reasonCode;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getOpTypeName() {
		return opTypeName;
	}

	public void setOpTypeName(String opTypeName) {
		this.opTypeName = opTypeName;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getForeignAccept() {
		return foreignAccept;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public void setForeignAccept(String foreignAccept) {
		this.foreignAccept = foreignAccept;
	}

	public String getRefundType() {
		return refundType;
	}

	public void setRefundType(String refundType) {
		this.refundType = refundType;
	}

	public long getRefundMoney() {
		return refundMoney;
	}

	public void setRefundMoney(long refundMoney) {
		this.refundMoney = refundMoney;
	}

	public String getRefundTypeName() {
		return refundTypeName;
	}

	public void setRefundTypeName(String refundTypeName) {
		this.refundTypeName = refundTypeName;
	}

	public String getSpCode() {
		return spCode;
	}

	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

	public String getOperCode() {
		return operCode;
	}

	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}

	public String getSpName() {
		return spName;
	}

	public void setSpName(String spName) {
		this.spName = spName;
	}

	public String getOperName() {
		return operName;
	}

	public void setOperName(String operName) {
		this.operName = operName;
	}

	public String getBillType() {
		return billType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

	public String getBillName() {
		return billName;
	}

	public void setBillName(String billName) {
		this.billName = billName;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getReasonName() {
		return reasonName;
	}

	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}

	@Override
	public String toString() {
		return "RefundEntity [phoneNo=" + phoneNo + ", idNo=" + idNo + ", loginAccept=" + loginAccept + ", opTypeName=" + opTypeName + ", beginTime="
				+ beginTime + ", endTime=" + endTime + ", opTime=" + opTime + ", foreignAccept=" + foreignAccept + ", refundType=" + refundType
				+ ", refundTypeName=" + refundTypeName + ", refundMoney=" + refundMoney + ", spCode=" + spCode + ", operCode=" + operCode
				+ ", spName=" + spName + ", operName=" + operName + ", billType=" + billType + ", billName=" + billName + ", regionName="
				+ regionName + ", loginNo=" + loginNo + ", reasonCode=" + reasonCode + ", reasonName=" + reasonName + "]";
	}

}
