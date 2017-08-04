package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S2313InDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "string", len = "20", desc = "服务号码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.BEGIN_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "查询类型", memo = "0:按月份查询    1：按日期查询")
	private int beginNo;

	@ParamDesc(path = "BUSI_INFO.END_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "查询年月", memo = "略")
	private int endNo;

	@ParamDesc(path = "BUSI_INFO.REGION_GROUP_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "地市groupID", memo = "略")
	private String regionGroupId;

	@ParamDesc(path = "BUSI_INFO.DISTINCT_GROUP_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "区县groupID", memo = "略")
	private String distinctGroupId;

	@ParamDesc(path = "BUSI_INFO.GROUP_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "营业厅", memo = "略")
	private String groupId;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		invCode = arg0.getStr(getPathByProperName("invCode"));
		beginNo = Integer.parseInt(arg0.getStr(getPathByProperName("beginNo")));
		endNo = Integer.parseInt(arg0.getStr(getPathByProperName("endNo")));
		regionGroupId = arg0.getStr(getPathByProperName("regionGroupId"));
		distinctGroupId = arg0.getStr(getPathByProperName("distinctGroupId"));
		groupId = arg0.getStr(getPathByProperName("groupId"));
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public int getBeginNo() {
		return beginNo;
	}

	public void setBeginNo(int beginNo) {
		this.beginNo = beginNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public String getRegionGroupId() {
		return regionGroupId;
	}

	public void setRegionGroupId(String regionGroupId) {
		this.regionGroupId = regionGroupId;
	}

	public String getDistinctGroupId() {
		return distinctGroupId;
	}

	public void setDistinctGroupId(String distinctGroupId) {
		this.distinctGroupId = distinctGroupId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}


}
