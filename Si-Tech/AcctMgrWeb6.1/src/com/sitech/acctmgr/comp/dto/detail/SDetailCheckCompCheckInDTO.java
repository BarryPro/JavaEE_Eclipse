package com.sitech.acctmgr.comp.dto.detail;

import com.sitech.acctmgr.atom.domains.detail.TargetPhoneEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/3/20.
 */
public class SDetailCheckCompCheckInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
    private String phoneno;

    @ParamDesc(path = "BUSI_INFO.PHONE_LIST", cons = ConsType.PLUS, desc = "对端号码列表", len = "14", type = "compx", memo = "略")
    private List<TargetPhoneEntity> phoneList = null;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneno = arg0.getStr(getPathByProperName("phoneno"));
        phoneList = arg0.getList(getPathByProperName("phoneList"), TargetPhoneEntity.class);
    }


    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }

    public List<TargetPhoneEntity> getPhoneList() {
        return phoneList;
    }

    public void setPhoneList(List<TargetPhoneEntity> phoneList) {
        this.phoneList = phoneList;
    }
}
