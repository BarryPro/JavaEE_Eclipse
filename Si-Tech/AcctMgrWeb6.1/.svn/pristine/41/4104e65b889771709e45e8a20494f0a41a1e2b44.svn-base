package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/6/5.
 */
public class BillOpenLv3Entity implements Serializable {
    @JSONField(name = "ThirdItemsName")
    @ParamDesc(path = "ThirdItemsName", cons = ConsType.CT001, type = "String", len = "2", desc = "帐单条目编码", memo = "01~06，09：其他")
    private String lv3ItemName;

    @JSONField(serialize = false)
    private String lv3ItemId;

    @JSONField(name = "ThirdItemsValue")
    @ParamDesc(path = "ThirdItemsValue", cons = ConsType.CT001, type = "String", len = "12", desc = "帐单条目值", memo = "单位：元，精确到分")
    private String realFee;

    @JSONField(serialize = false)
    private long longRealFee;

    @JSONField(serialize = false)
    private long longShouldFee;

    @JSONField(serialize = false)
    private long longFavourFee;

    public String getLv3ItemName() {
        return lv3ItemName;
    }

    public void setLv3ItemName(String lv3ItemName) {
        this.lv3ItemName = lv3ItemName;
    }

    public String getLv3ItemId() {
        return lv3ItemId;
    }

    public void setLv3ItemId(String lv3ItemId) {
        this.lv3ItemId = lv3ItemId;
    }

    public String getRealFee() {
        return realFee;
    }

    public void setRealFee(String realFee) {
        this.realFee = realFee;
    }

    public long getLongRealFee() {
        return longRealFee;
    }

    public void setLongRealFee(long longRealFee) {
        this.longRealFee = longRealFee;
    }

    public long getLongShouldFee() {
        return longShouldFee;
    }

    public void setLongShouldFee(long longShouldFee) {
        this.longShouldFee = longShouldFee;
    }

    public long getLongFavourFee() {
        return longFavourFee;
    }

    public void setLongFavourFee(long longFavourFee) {
        this.longFavourFee = longFavourFee;
    }

    @Override
    public String toString() {
        return "BillOpenLv3Entity{" +
                "lv3ItemName='" + lv3ItemName + '\'' +
                ", lv3ItemId='" + lv3ItemId + '\'' +
                ", realFee='" + realFee + '\'' +
                ", longRealFee=" + longRealFee +
                ", longShouldFee=" + longShouldFee +
                ", longFavourFee=" + longFavourFee +
                '}';
    }
}
