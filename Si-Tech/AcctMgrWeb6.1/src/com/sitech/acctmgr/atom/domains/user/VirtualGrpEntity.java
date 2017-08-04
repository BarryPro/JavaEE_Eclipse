package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class VirtualGrpEntity {
	/**
     */

	@JSONField(name = "UNIT_ID")
	@ParamDesc(path = "UNIT_ID", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private Long unitId;

	/**
     */
	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String unitName;

	/**
     */
	@JSONField(name = "GRP_CONTRACT_NO")
	@ParamDesc(path = "GRP_CONTRACT_NO", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String grpContractNo;

	/**
     */
	@JSONField(name = "GRP_PHONE_NO")
	@ParamDesc(path = "GRP_PHONE_NO", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String grpPhoneNo;

	/**
     */
	@JSONField(name = "LOGIN_ACCPET")
	@ParamDesc(path = "LOGIN_ACCPET", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private Long loginAccpet;

	/**
     */
	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String opTime;

	/**
     */
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String loginNo;

	/**
     */
	@JSONField(name = "GROUP_ID")
	@ParamDesc(path = "GROUP_ID", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String groupId;

	/**
     */
	@JSONField(name = "UPDATE_TIME")
	@ParamDesc(path = "UPDATE_TIME", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String updateTime;

	@JSONField(name = "PAY_FEE")
	@ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private long payFee;

	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private long idNo;

	@JSONField(name = "PAY_SN")
	@ParamDesc(path = "PAY_SN", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private long paySn;

	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, desc = "", type = "string", len = "10", memo = "")
	private String contractName;

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getPayFee() {
		return payFee;
	}

	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}

	public Long getUnitId() {
		return this.unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return this.unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public Long getLoginAccpet() {
		return this.loginAccpet;
	}

	public void setLoginAccpet(Long loginAccpet) {
		this.loginAccpet = loginAccpet;
	}

	public String getLoginNo() {
		return this.loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getGroupId() {
		return this.groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime
	 *            the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @return the grpContractNo
	 */
	public String getGrpContractNo() {
		return grpContractNo;
	}

	/**
	 * @param grpContractNo
	 *            the grpContractNo to set
	 */
	public void setGrpContractNo(String grpContractNo) {
		this.grpContractNo = grpContractNo;
	}

	/**
	 * @return the grpPhoneNo
	 */
	public String getGrpPhoneNo() {
		return grpPhoneNo;
	}

	/**
	 * @param grpPhoneNo
	 *            the grpPhoneNo to set
	 */
	public void setGrpPhoneNo(String grpPhoneNo) {
		this.grpPhoneNo = grpPhoneNo;
	}

	/**
	 * @return the updateTime
	 */
	public String getUpdateTime() {
		return updateTime;
	}

	/**
	 * @param updateTime
	 *            the updateTime to set
	 */
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Override
	public String toString() {
		return "VirtualGrpEntity [unitId=" + unitId + ", unitName=" + unitName + ", grpContractNo=" + grpContractNo + ", grpPhoneNo=" + grpPhoneNo
				+ ", loginAccpet=" + loginAccpet + ", opTime=" + opTime + ", loginNo=" + loginNo + ", groupId=" + groupId + ", updateTime="
				+ updateTime + ", payFee=" + payFee + ", idNo=" + idNo + ", paySn=" + paySn + "]";
	}

}
