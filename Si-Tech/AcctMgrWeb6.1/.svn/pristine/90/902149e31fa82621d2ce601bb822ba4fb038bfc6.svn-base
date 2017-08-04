package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/25.
 */
public class SFamilyFreeQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, desc = "账务月份", len = "6", type = "string", memo = "格式为YYYYMM；")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.CHAT_FLAG", cons = ConsType.CT001, desc = "家庭业务标识", len = "1", type = "string", memo = "0：查询亲情网用量；1：家庭畅聊；2：查询亲情网A用量；3：查询亲情网B用量；4：查询亲情网C用量；")
    private String chatFlag;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
        chatFlag = arg0.getStr(getPathByProperName("chatFlag"));
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

    public String getChatFlag() {
        return chatFlag;
    }

    public void setChatFlag(String chatFlag) {
        this.chatFlag = chatFlag;
    }
}
