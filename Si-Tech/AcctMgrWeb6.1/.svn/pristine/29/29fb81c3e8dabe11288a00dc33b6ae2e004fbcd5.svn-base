package com.sitech.acctmgr.atom.domains.base;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

/**
 *
 * <p>Title:   </p>
 * <p>Description:  缴费入账涉及到跟工号数据相关的公共节点 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class LoginBaseEntity {
	
	@JSONField(name="LOGIN_NO")
	private String loginNo;
	
	@JSONField(name="GROUP_ID")
	private String groupId;
	
	@JSONField(name="OP_CODE")
	private String opCode;
	
	@JSONField(name="OP_NOTE")
	private String opNote;

	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "LoginBaseEntity [loginNo=" + loginNo + ", groupId=" + groupId
				+ ", opCode=" + opCode + ", opNote=" + opNote + "]";
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
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}

	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}
	
}
