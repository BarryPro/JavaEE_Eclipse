package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/25.
 */
public class SMzoneFreeQueryInDTO extends CommonInDTO{
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
    private String phoneNo;

    /*
    @ParamDesc(path = "BUSI_INFO.PRC_ID", cons = ConsType.QUES, desc = "资费代码", len = "20", type = "string", memo = "offerid对应新系统值")
    private String prcId;

    @ParamDesc(path = "BUSI_INFO.RATE_CODE", cons = ConsType.QUES, desc = "二批代码", len = "4", type = "string", memo = "略")
    private String rateCode;
    */

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        /*prcId = arg0.getStr(getPathByProperName("prcId"));
        rateCode = arg0.getStr(getPathByProperName("rateCode"));*/
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    /*
    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getRateCode() {
        return rateCode;
    }

    public void setRateCode(String rateCode) {
        this.rateCode = rateCode;
    }
    */
}
