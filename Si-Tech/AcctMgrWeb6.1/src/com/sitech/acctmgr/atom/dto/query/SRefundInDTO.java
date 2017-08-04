package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：sp退费查询入参
 * 
 * @author liuhl
 *
 */
public class SRefundInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5961590252161851952L;
	/**
	 * 
	 */
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.STAR, type = "String", len = "40", desc = "服务号码", memo = "略")
	protected String phoneNo = "";

	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, type = "String", len = "40", desc = "开始时间", memo = "略")
	protected String beginTime;

	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, type = "String", len = "40", desc = "结束时间", memo = "略")
	protected String endTime;

	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, type = "String", len = "40", desc = "查询类型  0:全部  1：GRPS退费，2：梦网及自有业务退费查询  3:10086人工退费查询", memo = "略")
	protected String queryType;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (arg0.getStr(getPathByProperName("phoneNo")) != null && !arg0.getStr(getPathByProperName("phoneNo")).equals("")) {
			setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		}
		// setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
		setQueryType(arg0.getStr(getPathByProperName("queryType")));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}