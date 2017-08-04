package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 作用：4G共享流量查询每个成员使用共享流量情况作封装
 * Created by wangyla on 2016/7/26.
 */
public class Shared4GInfoEntity implements Serializable {
    @JSONField(name = "MEMBER_PHONE")
    @ParamDesc(path = "MEMBER_PHONE", desc = "共享4G家庭成员服务号码", len = "15", cons = ConsType.CT001, type = "String", memo = "")
    private String memPhone;
    @JSONField(name = "MEMBER_SHARED_USED")
    @ParamDesc(path = "MEMBER_SHARED_USED", desc = "成员已使用共享流量", len = "14", cons = ConsType.CT001, type = "String", memo = "单位：KB")
    private String sharedUsed;

    @JSONField(serialize = false)
    private long longSharedUsed;

    public String getMemPhone() {
        return memPhone;
    }

    public void setMemPhone(String memPhone) {
        this.memPhone = memPhone;
    }

    public String getSharedUsed() {
        return sharedUsed;
    }

    public void setSharedUsed(String sharedUsed) {
        this.sharedUsed = sharedUsed;
    }

    public long getLongSharedUsed() {
        return longSharedUsed;
    }

    public void setLongSharedUsed(long longSharedUsed) {
        this.longSharedUsed = longSharedUsed;
    }
}
