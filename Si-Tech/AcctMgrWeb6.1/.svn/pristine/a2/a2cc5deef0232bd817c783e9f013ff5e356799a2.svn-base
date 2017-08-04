package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：资源使用情况信息
 * <li>用于Wlan接口出参</li>
 * <li>用于优惠信息汇总时基于业务类型的数据实体</li>
 *
 * Created by wangyla on 2016/7/18.
 */
public class FreeUseInfoEntity implements Serializable {
    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "套餐内总优惠", memo = "")
    private String total;

    @JSONField(serialize = false)
    private long longTotal;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001, len = "14", type = "String", desc = "总使用量（含套餐外使用量）", memo = "")
    private String used;

    @JSONField(serialize = false)
    private long longUsed;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "剩余量", memo = "")
    private String remain;

    @JSONField(serialize = false)
    private long longRemain;

    @JSONField(name = "OUT_MEAL")
    @ParamDesc(path = "OUT_MEAL", cons = ConsType.CT001, len = "14", type = "String", desc = "套餐外使用量", memo = "")
    private String outMeal;

    @JSONField(serialize = false)
    private long longOutMeal;

    @JSONField(name = "UNIT")
    @ParamDesc(path = "UNIT", desc = "计量单位", cons = ConsType.CT001, len = "", memo = "")
    private String unit;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", desc = "计量单位名称", cons = ConsType.CT001, len = "", memo = "")
    private String unitName;

    @JSONField(serialize = false)
    private String favType;

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

    public String getOutMeal() {
        return outMeal;
    }

    public void setOutMeal(String outMeal) {
        this.outMeal = outMeal;
    }

    public long getLongOutMeal() {
        return longOutMeal;
    }

    public void setLongOutMeal(long longOutMeal) {
        this.longOutMeal = longOutMeal;
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

    public String getFavType() {
        return favType;
    }

    public void setFavType(String favType) {
        this.favType = favType;
    }

    @Override
    public String toString() {
        return "FreeUseInfoEntity{" +
                "total='" + total + '\'' +
                ", longTotal=" + longTotal +
                ", used='" + used + '\'' +
                ", longUsed=" + longUsed +
                ", remain='" + remain + '\'' +
                ", longRemain=" + longRemain +
                ", outMeal='" + outMeal + '\'' +
                ", longOutMeal=" + longOutMeal +
                ", unit='" + unit + '\'' +
                ", unitName='" + unitName + '\'' +
                ", favType='" + favType + '\'' +
                '}';
    }
}
