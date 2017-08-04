package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：家庭共享流量展示实体
 *
 * Created by wangyla on 2016/7/18.
 */
public class FamFreeUseInfoEntity implements Serializable {
    @JSONField(name = "PRC_ID")
    @ParamDesc(path = "PRC_ID", desc = "资费ID", cons = ConsType.CT001, len = "10", memo = "")
    private String prcId;

    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", desc = "资费名称", cons = ConsType.CT001, len = "60", memo = "")
    private String prcidName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "总优惠", memo = "")
    private String total;

    @JSONField(serialize = false)
    private long longTotal;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001, len = "14", type = "String", desc = "使用量", memo = "")
    private String used;

    @JSONField(serialize = false)
    private long longUsed;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "剩余量", memo = "")
    private String remain;

    @JSONField(serialize = false)
    private long longRemain;

    @JSONField(name = "UNIT")
    @ParamDesc(path = "UNIT", desc = "计量单位", cons = ConsType.CT001, len = "", memo = "")
    private String unit;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", desc = "计量单位名称", cons = ConsType.CT001, len = "", memo = "")
    private String unitName;

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getPrcidName() {
        return prcidName;
    }

    public void setPrcidName(String prcidName) {
        this.prcidName = prcidName;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public long getLongTotal() {
        return longTotal;
    }

    public void setLongTotal(long longTotal) {
        this.longTotal = longTotal;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public long getLongUsed() {
        return longUsed;
    }

    public void setLongUsed(long longUsed) {
        this.longUsed = longUsed;
    }

    public String getRemain() {
        return remain;
    }

    public void setRemain(String remain) {
        this.remain = remain;
    }

    public long getLongRemain() {
        return longRemain;
    }

    public void setLongRemain(long longRemain) {
        this.longRemain = longRemain;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    @Override
    public String toString() {
        return "FamFreeUseInfoEntity{" +
                "prcId='" + prcId + '\'' +
                ", prcidName='" + prcidName + '\'' +
                ", total='" + total + '\'' +
                ", longTotal=" + longTotal +
                ", used='" + used + '\'' +
                ", longUsed=" + longUsed +
                ", remain='" + remain + '\'' +
                ", longRemain=" + longRemain +
                ", unit='" + unit + '\'' +
                ", unitName='" + unitName + '\'' +
                '}';
    }
}
