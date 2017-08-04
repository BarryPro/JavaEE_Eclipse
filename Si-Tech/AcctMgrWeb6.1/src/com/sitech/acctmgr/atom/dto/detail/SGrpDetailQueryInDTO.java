package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.StringUtils;

/**
 * Created by wangyla on 2016/12/20.
 */
public class SGrpDetailQueryInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.GRP_CUST_ID", cons = ConsType.CT001, desc = "集团客户ID", len = "18", type = "string", memo = "略")
    private long grpCustId;

    @ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, desc = "查询详单类型", len = "1", type = "string", memo = "取值 00：默认查询全部详单；非零：指定详单类型")
    private String queryType;

    @ParamDesc(path = "BUSI_INFO.QUERY_FLAG", cons = ConsType.CT001, desc = "查询时间类型", len = "1", type = "string", memo = "0按时间段查询，要求传BEGIN_TIME和END_TIME参数。1按账务月查询，要求传YEAR_MONTH参数")
    private String queryFlag;

    @ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.QUES, desc = "开始时间", len = "8", type = "string", memo = "按照时间段查询详单，开始日期，格式为YYYYMMDD。当使用此参数时QUERY_FLAG参数填0，且YEAR_MONTH参数不起作用。")
    private String begintime;
    @ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.QUES, desc = "结束时间", len = "8", type = "string", memo = "按照时间段查询详单，结束日期，格式为YYYYMMDD。当使用此参数时QUERY_FLAG参数填0，且YEAR_MONTH参数不起作用。")
    private String endtime;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.QUES, desc = "账务月份", len = "6", type = "string", memo = "账务月。格式为YYYYMM；使用year_month时，query_flag必须传1")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.CONFERENCE_ID", cons = ConsType.QUES, desc = "会议ID", len = "20", type = "string", memo = "移动会议查询使用此参数")
    private String conferenceId;

    @ParamDesc(path = "BUSI_INFO.CALLING_NUMBER", cons = ConsType.QUES, desc = "会议发起人号码", len = "64", type = "string", memo = "移动会议查询使用此参数")
    private String callingNumber;

    @ParamDesc(path = "BUSI_INFO.IS_PAGE", cons = ConsType.QUES, desc = "是否分页", len = "6", type = "string", memo = "Y：分页；N：不分页")
    private String isPage;

    @ParamDesc(path = "BUSI_INFO.PAGE_NO", cons = ConsType.QUES, desc = "页码", len = "6", type = "string", memo = "表示第几页")
    private int pageNo;

    @ParamDesc(path = "BUSI_INFO.PAGE_SIZE", cons = ConsType.QUES, desc = "每页展示条数", len = "6", type = "string", memo = "")
    private int pageSize;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        grpCustId = Long.parseLong(arg0.getStr(getPathByProperName("grpCustId")));
        queryType = arg0.getStr(getPathByProperName("queryType"));
        queryFlag = arg0.getStr(getPathByProperName("queryFlag"));
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("begintime")))) {
            begintime = arg0.getStr(getPathByProperName("begintime"));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("endtime")))) {
            endtime = arg0.getStr(getPathByProperName("endtime"));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("yearMonth")))) {
            yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
        }

        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("conferenceId")))) {
            conferenceId = arg0.getStr(getPathByProperName("conferenceId"));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("callingNumber")))) {
            callingNumber = arg0.getStr(getPathByProperName("callingNumber"));
        }

        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("isPage")))) {
            isPage = arg0.getStr(getPathByProperName("isPage"));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("pageNo")))) {
            pageNo = Integer.parseInt(arg0.getStr(getPathByProperName("pageNo")));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("pageSize")))) {
            pageSize = Integer.parseInt(arg0.getStr(getPathByProperName("pageSize")));
        }
    }

    public long getGrpCustId() {
        return grpCustId;
    }

    public void setGrpCustId(long grpCustId) {
        this.grpCustId = grpCustId;
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

    public String getBegintime() {
        return begintime;
    }

    public void setBegintime(String begintime) {
        this.begintime = begintime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    public String getCallingNumber() {
        return callingNumber;
    }

    public void setCallingNumber(String callingNumber) {
        this.callingNumber = callingNumber;
    }

    public String getIsPage() {
        return isPage;
    }

    public void setIsPage(String isPage) {
        this.isPage = isPage;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
