package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/6/6.
 */
public class SFreeOpenGprsQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.ServiceNumber", cons = ConsType.CT001, desc = "手机号码", len = "11", type = "string", memo = "略")
    private String phoneNo;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }
}
