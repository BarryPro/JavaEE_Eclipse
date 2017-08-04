package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/6/5.
 */
public class SPhoneBillOpenQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.ServiceType", cons = ConsType.CT001, desc = "标识类型", len = "2", type = "string", memo = "01：手机号码;02：固话号码;03：宽带帐号;04：vip卡号;05：集团编码；本期只有01：手机号码")
    private String serviceType;

    @ParamDesc(path = "BUSI_INFO.ServiceNumber", cons = ConsType.CT001, desc = "服务号码", len = "32", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.BgnMonth", cons = ConsType.QUES, desc = "账单查询起始月", len = "6", type = "string", memo = "格式：YYYYMM；为空时，默认查询当月")
    private int beginMonth;

    @ParamDesc(path = "BUSI_INFO.EndMonth", cons = ConsType.QUES, desc = "账单查询结束月", len = "6", type = "string", memo = "格式：YYYYMM；为空时，默认查询当月")
    private int endMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        serviceType = arg0.getStr(getPathByProperName("serviceType"));
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("beginMonth")))) {
            beginMonth = Integer.parseInt(arg0.getStr(getPathByProperName("beginMonth")));
        } else {
            beginMonth = DateUtils.getCurYm();
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("endMonth")))) {
            endMonth = Integer.parseInt(arg0.getStr(getPathByProperName("endMonth")));
        } else {
            endMonth = DateUtils.getCurYm();
        }
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public int getBeginMonth() {
        return beginMonth;
    }

    public void setBeginMonth(int beginMonth) {
        this.beginMonth = beginMonth;
    }

    public int getEndMonth() {
        return endMonth;
    }

    public void setEndMonth(int endMonth) {
        this.endMonth = endMonth;
    }
}
