package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/12/23.
 */
public class SPhoneBillQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.BEGIN_MONTH", cons = ConsType.CT001, desc = "查询开始月", len = "6", type = "string", memo = "略")
    private int beginMonth;

    @ParamDesc(path = "BUSI_INFO.END_MONTH", cons = ConsType.CT001, desc = "查询结束年月", len = "6", type = "string", memo = "略")
    private int endMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        beginMonth = Integer.parseInt(arg0.getStr(getPathByProperName("beginMonth")));
        endMonth = Integer.parseInt(arg0.getStr(getPathByProperName("endMonth")));
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
