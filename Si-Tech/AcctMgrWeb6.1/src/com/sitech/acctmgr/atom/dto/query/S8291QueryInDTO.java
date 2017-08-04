package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/11/11.
 */
public class S8291QueryInDTO extends CommonInDTO {

    @ParamDesc(path="BUSI_INFO.PHONE_NO",cons= ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
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
