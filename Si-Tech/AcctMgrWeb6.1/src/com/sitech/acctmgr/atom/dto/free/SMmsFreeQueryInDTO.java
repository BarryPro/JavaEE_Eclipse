package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/2/23.
 */
public class SMmsFreeQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.QUES, desc = "账务月份", len = "6", type = "string", memo = "格式为YYYYMM；")
    private int yearMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

}
