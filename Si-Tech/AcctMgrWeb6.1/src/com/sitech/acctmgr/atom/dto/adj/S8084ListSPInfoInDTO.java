package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8084ListSPInfoInDTO extends CommonInDTO{


	/**
	 * 
	 */
	private static final long serialVersionUID = 233787045349846354L;
	
	 @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
	    private String phoneNo;

	    @ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, desc = "查询类型", len = "3", type = "string", memo = "取值 0：全部SP，其他传 800 ~ 835")
	    private String queryType;

	    @ParamDesc(path = "BUSI_INFO.QUERY_FLAG", cons = ConsType.CT001, desc = "查询时间类型", len = "1", type = "string", memo = "0按时间段查询，要求传BEGIN_TIME和END_TIME参数")
	    private String queryFlag;

	    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.QUES, desc = "账务月份", len = "6", type = "Long", memo = "账务月。格式为YYYYMM；使用year_month时，query_flag必须传1")
	    private int yearMonth;

	    @Override
	    public void decode(MBean arg0) {
	        super.decode(arg0);
	        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
	        queryType = arg0.getStr(getPathByProperName("queryType"));
	        queryFlag = arg0.getStr(getPathByProperName("queryFlag"));
	        if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("yearMonth")))) {
	            yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
	        }
	    }

	    public String getPhoneNo() {
	        return phoneNo;
	    }

	    public void setPhoneNo(String phoneNo) {
	        this.phoneNo = phoneNo;
	    }

	    public String getQueryType() {
	        return queryType;
	    }

	    public void setQueryType(String queryType) {
	        this.queryType = queryType;
	    }

	    public String getQueryFlag() {
	        return queryFlag;
	    }

	    public void setQueryFlag(String queryFlag) {
	        this.queryFlag = queryFlag;
	    }

	    public int getYearMonth() {
	        return yearMonth;
	    }

	    public void setYearMonth(int yearMonth) {
	        this.yearMonth = yearMonth;
	    }
}
