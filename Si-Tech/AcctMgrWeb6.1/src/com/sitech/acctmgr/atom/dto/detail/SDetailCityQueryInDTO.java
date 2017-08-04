package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.StringUtils;

/**
 * Created by wangyla on 2016/7/12.
 */
public class SDetailCityQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, desc = "查询类型", len = "1", type = "string", memo = "取值 0：默认查询全部详单；非零：指定详单类型")
    private String queryType;

    @ParamDesc(path = "BUSI_INFO.QUERY_FLAG", cons = ConsType.CT001, desc = "查询时间类型", len = "1", type = "string", memo = "0按时间段查询，要求传BEGIN_TIME和END_TIME参数。1按账务月查询，要求传YEAR_MONTH参数")
    private String queryFlag;

    @ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.QUES, desc = "开始时间", len = "8", type = "string", memo = "按照时间段查询详单，开始日期，格式为YYYYMMDD。当使用此参数时QUERY_FLAG参数填0，且YEAR_MONTH参数不起作用。")
    private String begintime;
    @ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.QUES, desc = "结束时间", len = "8", type = "string", memo = "按照时间段查询详单，结束日期，格式为YYYYMMDD。当使用此参数时QUERY_FLAG参数填0，且YEAR_MONTH参数不起作用。")
    private String endtime;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.QUES, desc = "账务月份", len = "6", type = "string", memo = "账务月。格式为YYYYMM；使用year_month时，query_flag必须传1")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.OPR_TYPE", cons = ConsType.QUES, desc = "操作类型", len = "", type = "string", memo = "0：资费代码验证；1：实时帐务验证；2：程序上线验证；3：安保部详单查询；4：投诉处理；5：其他类")
    private String oprType;

    @ParamDesc(path = "BUSI_INFO.POWER_LEVEL", cons = ConsType.CT001, desc = "语音话单类型", len = "1", type = "string", memo = "0：普通；1：高级")
    private String powerLevel;

    @ParamDesc(path = "BUSI_INFO.ORDER_NO", cons = ConsType.CT001, desc = "处理工单号", len = "20", type = "string", memo = "")
    private String orderNo;

    @ParamDesc(path = "BUSI_INFO.REASON", cons = ConsType.QUES, desc = "查询原因", len = "40", type = "string", memo = "")
    private String reason;

    @ParamDesc(path = "BUSI_INFO.DYNAMIC_PASSWD", cons = ConsType.QUES, desc = "动态验证密码", len = "6", type = "string", memo = "")
    private String dynamicPasswd;

    @ParamDesc(path = "BUSI_INFO.CONTACT_PHONE", cons = ConsType.QUES, desc = "与客户联系的电话", len = "40", type = "string", memo = "")
    private String contactPhone;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
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
        oprType = arg0.getStr(getPathByProperName("oprType"));
        powerLevel = arg0.getStr(getPathByProperName("powerLevel"));
        orderNo = arg0.getStr(getPathByProperName("orderNo"));
        reason = arg0.getStr(getPathByProperName("reason"));
        dynamicPasswd = arg0.getStr(getPathByProperName("dynamicPasswd"));
        contactPhone = arg0.getStr(getPathByProperName("contactPhone"));
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

    public String getOprType() {
        return oprType;
    }

    public void setOprType(String oprType) {
        this.oprType = oprType;
    }

    public String getPowerLevel() {
        return powerLevel;
    }

    public void setPowerLevel(String powerLevel) {
        this.powerLevel = powerLevel;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getDynamicPasswd() {
        return dynamicPasswd;
    }

    public void setDynamicPasswd(String dynamicPasswd) {
        this.dynamicPasswd = dynamicPasswd;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
}
