package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/14.
 */
public class SGPRSBillQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "40", desc = "服务号码", memo = "")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "string", len = "6", desc = "账务年月", memo = "YYYYMM")
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
