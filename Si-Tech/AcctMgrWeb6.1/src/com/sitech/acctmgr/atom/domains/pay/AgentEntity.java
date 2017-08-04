package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 
* @Title:   []
* @Description: 空中充值代理商
* @Date : 2015年3月12日下午6:01:25
* @Company: SI-TECH
* @author : qiaolin
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class AgentEntity implements Serializable {

	@JSONField(name="AGENT_PHONE")
	@ParamDesc(path="AGENT_PHONE",cons=ConsType.CT001,type="String",len="18",desc="空中充值代理商手机号码",memo="略")
	private String 	agentPhone;
	
	@JSONField(name="AGENT_CONNO")
	@ParamDesc(path="AGENT_CONNO",cons=ConsType.CT001,type="long",len="18",desc="空中充值代理商账号",memo="略")
	private long 	agentConNo;

	@JSONField(name="REGION_GROUPID")
	@ParamDesc(path="REGION_GROUPID",cons=ConsType.CT001,type="String",len="10",desc="地市group_id",memo="略")
	private String regionGroupId;
	
	@JSONField(name="REGION_GROUPNAME")
	@ParamDesc(path="REGION_GROUPNAME",cons=ConsType.CT001,type="String",len="100",desc="地市名称",memo="略")
	private String regionGroupName;
	
	@JSONField(name="DISTRICT_GROUPID")
	@ParamDesc(path="DISTRICT_GROUPID",cons=ConsType.CT001,type="String",len="10",desc="区县group_id",memo="略")
	private String districtGroupId;
	
	@JSONField(name="DISTRICT_GROUPNAME")
	@ParamDesc(path="DISTRICT_GROUPNAME",cons=ConsType.CT001,type="String",len="100",desc="区县名称",memo="略")
	private String districtGroupName;


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AgentEntity [agentPhone=" + agentPhone + ", agentConNo=" + agentConNo + ", regionGroupId=" + regionGroupId
				+ ", regionGroupName=" + regionGroupName + ", districtGroupId=" + districtGroupId + ", districtGroupName="
				+ districtGroupName + "]";
	}


	public String getAgentPhone() {
		return agentPhone;
	}


	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}


	public long getAgentConNo() {
		return agentConNo;
	}


	public void setAgentConNo(long agentConNo) {
		this.agentConNo = agentConNo;
	}


	public String getRegionGroupId() {
		return regionGroupId;
	}


	public void setRegionGroupId(String regionGroupId) {
		this.regionGroupId = regionGroupId;
	}


	public String getRegionGroupName() {
		return regionGroupName;
	}


	public void setRegionGroupName(String regionGroupName) {
		this.regionGroupName = regionGroupName;
	}


	public String getDistrictGroupId() {
		return districtGroupId;
	}


	public void setDistrictGroupId(String districtGroupId) {
		this.districtGroupId = districtGroupId;
	}


	public String getDistrictGroupName() {
		return districtGroupName;
	}


	public void setDistrictGroupName(String districtGroupName) {
		this.districtGroupName = districtGroupName;
	}

}
