package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

public class GroupInfoEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L; 
	@JSONField(name="GROUP_ID")
	@ParamDesc(path="GROUP_ID",cons=ConsType.CT001,len="40",desc="地市ID",type="String",memo="略")
	private String groupId;
	
	@JSONField(name="PARENT_GROUP_ID")
	@ParamDesc(path="PARENT_GROUP_ID",cons=ConsType.CT001,len="40",desc="上级地市ID",type="String",memo="略")
	private String parentGroupId;
	
	@JSONField(name="PROVINCE_ID")
	@ParamDesc(path="PROVINCE_ID",cons=ConsType.CT001,len="40",desc="省市ID",type="String",memo="略")
	private String provinceId;
	
	@JSONField(name="PARENT_LEVEL")
	@ParamDesc(path="PARENT_LEVEL",cons=ConsType.CT001,len="40",desc="上级地市所在等级",type="String",memo="略")
	private String parentLevel;
	
	@JSONField(name="CURRENT_LEVEL")
	@ParamDesc(path="CURRENT_LEVEL",cons=ConsType.CT001,len="40",desc="当前地市所处位置",type="String",memo="略")
	private String currentLevel;
	
	@JSONField(name="GROUP_NAME")
	@ParamDesc(path="GROUP_NAME",cons=ConsType.CT001,len="40",desc="地市名称",type="String",memo="略")
	private String groupName;
	
	@JSONField(name="IS_PARENT")
	@ParamDesc(path="IS_PARENT",cons=ConsType.CT001,len="40",desc="是否为父类节点",type="boolean",memo="略")
	private boolean isParent;
	
	@JSONField(name="REGION_ID")
	@ParamDesc(path="REGION_ID",cons=ConsType.CT001,len="40",desc="地市代码",type="String",memo="略")
	private String regionId;

	
	
	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getParentGroupId() {
		return parentGroupId;
	}

	public void setParentGroupId(String parentGroupId) {
		this.parentGroupId = parentGroupId;
	}

	public String getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	public String getParentLevel() {
		return parentLevel;
	}

	public void setParentLevel(String parentLevel) {
		this.parentLevel = parentLevel;
	}

	public String getCurrentLevel() {
		return currentLevel;
	}

	public void setCurrentLevel(String currentLevel) {
		this.currentLevel = currentLevel;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}

	@Override
	public String toString() {
		return "GroupInfoEntity [groupId=" + groupId + ", parentGroupId="
				+ parentGroupId + ", provinceId=" + provinceId
				+ ", parentLevel=" + parentLevel + ", currentLevel="
				+ currentLevel + ", groupName=" + groupName + ", isParent="
				+ isParent + "]";
	}
	
	

}
