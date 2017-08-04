package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/5/10.
 */
public class SGMBalanceQueryInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号码", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.SEND_FLAG", cons = ConsType.QUES, type = "String", len = "2", desc = "是否下发短信", memo = "Y：发，不传，空或N：不发")
    private String sendFlag;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("sendFlag")))){
            sendFlag = arg0.getStr(getPathByProperName("sendFlag"));
        }
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getSendFlag() {
        return sendFlag;
    }

    public void setSendFlag(String sendFlag) {
        this.sendFlag = sendFlag;
    }
}

