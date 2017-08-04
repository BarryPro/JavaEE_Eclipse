package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：根据inv_no 查询发票记录表入参
 * 
 * @author liuhl_bj
 *
 */
public class S8240qryInvoByInvNoInDTO extends CommonInDTO {

	private static final long serialVersionUID = -939270329172640327L;
	@ParamDesc(path = "BUSI_INFO.LOGIN_NO", cons = ConsType.STAR, type = "String", len = "20", desc = "工号", memo = "略")
	private String loginNo;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.STAR, type = "String", len = "20", desc = "发票号", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.STAR, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, type = "int", len = "20", desc = "开始时间", memo = "略")
	private int beginTime;

	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, type = "int", len = "20", desc = "结束时间", memo = "略")
	private int endTime;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.STAR, type = "string", len = "10", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.STATE", cons = ConsType.STAR, type = "string", len = "10", desc = "查询状态", memo = "略")
	private String state;

	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.STAR, type = "int", len = "10", desc = "页码", memo = "略")
	private int pageNum;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invNo")))) {
			invNo = arg0.getStr(getPathByProperName("invNo"));
		}
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invCode")))) {
			invCode = arg0.getStr(getPathByProperName("invCode"));
		}
		beginTime = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginTime")));
		endTime = ValueUtils.intValue(arg0.getStr(getPathByProperName("endTime")));
		pageNum = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageNum")));
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("state")))) {
			state = arg0.getStr(getPathByProperName("state"));
		}
		if (StringUtils.isNotEmpty(getPathByProperName("loginNo"))) {
			loginNo = arg0.getStr(getPathByProperName("loginNo"));
		}
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public int getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(int beginTime) {
		this.beginTime = beginTime;
	}

	public int getEndTime() {
		return endTime;
	}

	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

}
