package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SProductOfferUpQueryInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.UP_ID", cons = ConsType.CT001, type = "String", len = "15", desc = "升级关系ID", memo = "略")
	private String upId;
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "手机号码", memo = "略")
	private String phoneNo;
	
	@ParamDesc(path = "BUSI_INFO.TOTAL_DATE", cons = ConsType.CT001, type = "int", len = "6", desc = "操作年月", memo = "略")
	private int totalDate;
	
	@ParamDesc(path = "BUSI_INFO.OPR_FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "操作标识", memo = "q：表示查询；d：表示删除")
	private String oprFlag;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		upId = arg0.getStr(getPathByProperName("upId"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		totalDate = Integer.parseInt(arg0.getStr(getPathByProperName("totalDate")));
		oprFlag = arg0.getStr(getPathByProperName("oprFlag"));
	}

	public String getUpId() {
		return upId;
	}

	public void setUpId(String upId) {
		this.upId = upId;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	public String getOprFlag() {
		return oprFlag;
	}

	public void setOprFlag(String oprFlag) {
		this.oprFlag = oprFlag;
	}
	
}
