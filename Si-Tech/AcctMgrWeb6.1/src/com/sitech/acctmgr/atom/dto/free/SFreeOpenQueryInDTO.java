package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/6/6.
 */
public class SFreeOpenQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.ServiceType", cons = ConsType.CT001, desc = "标识类型", len = "2", type = "string", memo = "01：手机号码;02：固话号码;03：宽带帐号;04：vip卡号;05：集团编码；本期只有01：手机号码")
    private String serviceType;

    @ParamDesc(path = "BUSI_INFO.ServiceNumber", cons = ConsType.CT001, desc = "服务号码", len = "32", type = "string", memo = "略")
    private String phoneNo;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        serviceType = arg0.getStr(getPathByProperName("serviceType"));
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
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
}
