package com.sitech.acctmgr.atom.domains.volume;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/2/21.
 */
public class TransferOtherEntity implements Serializable {
    @JSONField(name = "OTHER_PARTY")
    @ParamDesc(path = "OTHER_PARTY", cons = ConsType.CT001, type = "string", len = "15", desc = "转移对象", memo = "")
    private String otherParty;
    @JSONField(name = "USER_ID")
    @ParamDesc(path = "USER_ID", cons = ConsType.CT001, type = "string", len = "15", desc = "转移对象用户ID", memo = "")
    private String userId;
    @JSONField(name = "OTHER_VALUE")
    @ParamDesc(path = "OTHER_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "转移流量额度", memo = "单位：KB")
    private String otherValue;

    public String getOtherParty() {
        return otherParty;
    }

    public void setOtherParty(String otherParty) {
        this.otherParty = otherParty;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOtherValue() {
        return otherValue;
    }

    public void setOtherValue(String otherValue) {
        this.otherValue = otherValue;
    }
}
