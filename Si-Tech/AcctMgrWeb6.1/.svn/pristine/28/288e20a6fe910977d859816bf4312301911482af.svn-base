package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class QryBillApxInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, desc = "账务年月", len = "6", type = "string", memo = "YYYYMM")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
    private String phoneNo;

    public QryBillApxInDTO() {
    }

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }


}
