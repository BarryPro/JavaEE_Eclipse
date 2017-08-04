package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/6/12.
 */
public class FreeDetailLv3InEntity implements Serializable {

    @JSONField(name = "totalRes")
    @ParamDesc(path = "totalRes", cons = ConsType.CT001, type = "string", len = "12", desc = "资源总量", memo = "")
    private String total;

    @JSONField(name = "UsedRes")
    @ParamDesc(path = "UsedRes", cons = ConsType.CT001, type = "string", len = "12", desc = "资源已使用量", memo = "")
    private String used;

    @JSONField(name = "RemainRes")
    @ParamDesc(path = "RemainRes", cons = ConsType.CT001, type = "string", len = "12", desc = "资源剩余量", memo = "")
    private String remain;

    @JSONField(name = "Unit")
    @ParamDesc(path = "Unit", cons = ConsType.CT001, type = "string", len = "2", desc = "资源单位", memo = "01：分钟；02：条数；03：KB；04：MB；05：GB")
    private String unit;

    @JSONField(name = "ValidDate")
    @ParamDesc(path = "ValidDate", cons = ConsType.QUES, type = "string", len = "14", desc = "有效截止时间", memo = "格式：yyyyMMddHHmmss")
    private String expireTime;

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public String getRemain() {
        return remain;
    }

    public void setRemain(String remain) {
        this.remain = remain;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }
}
