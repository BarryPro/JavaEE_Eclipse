package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.base.GroupListEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SGetGroupListOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = 1L;
	
	@JSONField(name = "LIST_GROUPS")
	@ParamDesc(path = "LIST_GROUPS", cons = ConsType.STAR, type = "compx", len = "1", desc = "营业厅列表", memo = "略")
	protected List<GroupListEntity> groupList;

	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("groupList"), groupList);
		return result;
		}

	public List<GroupListEntity> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<GroupListEntity> groupList) {
		this.groupList = groupList;
	}

}
