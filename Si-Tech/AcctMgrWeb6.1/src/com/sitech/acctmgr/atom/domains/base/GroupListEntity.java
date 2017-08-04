package com.sitech.acctmgr.atom.domains.base;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class GroupListEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name = "GROUP_ID")
	@ParamDesc(path = "GROUP_ID", cons = ConsType.CT001, type = "string", len = "128", desc = "group_id", memo = "略")
	private String groupId;
	
	@JSONField(name = "GROUP_NAME")
	@ParamDesc(path = "GROUP_NAME", cons = ConsType.CT001, type = "string", len = "18", desc = "名称", memo = "略")
	private String groupName;

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	@Override
	public String toString() {
		return "GroupListEntity [groupId=" + groupId + ", groupName=" + groupName + "]";
	}
	
}
