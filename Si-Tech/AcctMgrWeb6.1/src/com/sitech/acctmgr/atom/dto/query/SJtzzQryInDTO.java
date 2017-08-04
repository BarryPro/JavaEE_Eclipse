package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SJtzzQryInDTO extends CommonInDTO {


	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, type = "String", len = "15", desc = "集团编码", memo = "略")
	private String unitId;
	@ParamDesc(path = "BUSI_INFO.OP_PHONE", cons = ConsType.CT001, type = "String", len = "15", desc = "操作员手机号", memo = "略")
	private String opPhone;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "15", desc = "被赠送人手机号码", memo = "略")
	private String phoneNo;
	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, type = "String", len = "14", desc = "起始时间", memo = "YYYYMMDDHHMISS")
	private String beginTime;
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, type = "String", len = "14", desc = "结束时间", memo = "YYYYMMDDHHMISS")
	private String endTime;
	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "String", len = "5", desc = "查询第几页", memo = "")
	private String pageNum;
	@ParamDesc(path = "BUSI_INFO.PAGE_COUNT", cons = ConsType.CT001, type = "String", len = "5", desc = "查询每页展示的条数", memo = "")
	private String pageCount;
	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "查询类型", memo = "0:成功,1:处理中,2:失败 ,3:查询全部")
	private String queryType;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		unitId = arg0.getStr(getPathByProperName("unitId"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		opPhone = arg0.getStr(getPathByProperName("opPhone"));
		beginTime = arg0.getStr(getPathByProperName("beginTime"));
		endTime = arg0.getStr(getPathByProperName("endTime"));
		if(arg0.getObject(getPathByProperName("pageNum")) != null && !arg0.getObject(getPathByProperName("pageNum")).equals("")) {
			pageNum = arg0.getStr(getPathByProperName("pageNum"));
		}
		if(arg0.getObject(getPathByProperName("pageCount")) != null && !arg0.getObject(getPathByProperName("pageCount")).equals("")) {
			pageCount = arg0.getStr(getPathByProperName("pageCount"));
		}
		
		queryType = arg0.getStr(getPathByProperName("queryType"));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the opPhone
	 */
	public String getOpPhone() {
		return opPhone;
	}

	/**
	 * @param opPhone the opPhone to set
	 */
	public void setOpPhone(String opPhone) {
		this.opPhone = opPhone;
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the pageNum
	 */
	public String getPageNum() {
		return pageNum;
	}

	/**
	 * @param pageNum the pageNum to set
	 */
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	/**
	 * @return the pageCount
	 */
	public String getPageCount() {
		return pageCount;
	}

	/**
	 * @param pageCount the pageCount to set
	 */
	public void setPageCount(String pageCount) {
		this.pageCount = pageCount;
	}

	/**
	 * @return the queryType
	 */
	public String getQueryType() {
		return queryType;
	}

	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

}
