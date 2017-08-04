package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.domains.user.GroupUserInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8014InitGrpOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="UNIT_ID")
	@ParamDesc(path="UNIT_ID",cons=ConsType.CT001,type="long",len="11",desc="集团编号",memo="略")
	private long unitId;
	@JSONField(name="GROUP_NAME")
	@ParamDesc(path="GROUP_NAME",cons=ConsType.CT001,type="String",len="20",desc="集团名称",memo="略")
	private String groupName;
	@JSONField(name="CUST_ID")
	@ParamDesc(path="CUST_ID",cons=ConsType.CT001,type="String",len="11",desc="集团ID",memo="略")
	private String custId;
	@JSONField(name="ICC_ID")
	@ParamDesc(path="ICC_ID",cons=ConsType.CT001,type="long",len="11",desc="证件号码",memo="略")
	private String iccId;
	@JSONField(name="GROUP_CONTRACT_LIST")
	@ParamDesc(path="GROUP_CONTRACT_LIST",cons=ConsType.CT001,type="compx",len="",desc="集团产品列表",memo="略")
	private List<GroupUserInfo> groupContractList ;
	
	@Override
    public MBean encode() {
        MBean result = new MBean();
        result.setBody(getPathByProperName("unitId"), unitId);
        result.setBody(getPathByProperName("groupName"), groupName);
        result.setBody(getPathByProperName("custId"), custId);
        result.setBody(getPathByProperName("iccId"), iccId);
        result.setBody(getPathByProperName("groupContractList"), groupContractList);
        return result;
    }

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getIccId() {
		return iccId;
	}

	public void setIccId(String iccId) {
		this.iccId = iccId;
	}

	public List<GroupUserInfo> getGroupContractList() {
		return groupContractList;
	}

	public void setGroupContractList(List<GroupUserInfo> groupContractList) {
		this.groupContractList = groupContractList;
	}

	@Override
	public String toString() {
		return "S8014InitGrpOutDTO [groupNo=" + unitId + ", groupName="
				+ groupName + ", groupId=" + custId + ", iccId=" + iccId
				+ ", groupContractList=" + groupContractList + "]";
	}
	
	
	
	
	
}
