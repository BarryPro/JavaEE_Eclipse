package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/11/11.
 */
public class S8291QueryOutDTO extends CommonOutDTO {

    @JSONField(name="PHONE_NO")
    @ParamDesc(path="PHONE_NO",cons= ConsType.CT001,type="String",len="40",desc="手机号码",memo="略")
    private String phoneNo;

    @JSONField(name="LOGIN_NO_OPR")
    @ParamDesc(path="LOGIN_NO_OPR",cons= ConsType.CT001,type="String",len="10",desc="录入的操作工号",memo="略")
    private String loginNoOpr;

    @JSONField(name="BEGIN_TIME")
    @ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, desc = "开始时间", len = "8", type = "string", memo = "开始日期，格式为YYYYMMDD")
    private String begintime;

    @JSONField(name="END_TIME")
    @ParamDesc(path = "END_TIME", cons = ConsType.CT001, desc = "结束时间", len = "8", type = "string", memo = "结束日期，格式为YYYYMMDD")
    private String endtime;

    @JSONField(name="QUERY_TYPE")
    @ParamDesc(path = "QUERY_TYPE", cons = ConsType.CT001, desc = "查询类型", len = "5", type = "string", memo = "详单类型")
    private String queryType;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setBody(getPathByProperName("phoneNo"), phoneNo);
        result.setBody(getPathByProperName("loginNoOpr"), loginNoOpr);
        result.setBody(getPathByProperName("begintime"), begintime);
        result.setBody(getPathByProperName("endtime"), endtime);
        result.setBody(getPathByProperName("queryType"), queryType);
        return result;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getLoginNoOpr() {
        return loginNoOpr;
    }

    public void setLoginNoOpr(String loginNoOpr) {
        this.loginNoOpr = loginNoOpr;
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

    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }
}
