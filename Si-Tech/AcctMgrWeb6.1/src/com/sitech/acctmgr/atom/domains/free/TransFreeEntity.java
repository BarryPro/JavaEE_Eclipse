package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/3/8.
 * 可转分类流量优惠数据实体
 */
public class TransFreeEntity implements Serializable {
    @JSONField(name = "GPRS_REGION_TYPE")
    @ParamDesc(path = "GPRS_REGION_TYPE", desc = "流量地域限制分类", cons = ConsType.CT001, len = "", memo = "取值：01，国内流量；02，区域流量；null，此参数无效")
    private String gprsRegionType;

    @JSONField(name = "PRC_ID")
    @ParamDesc(path = "PRC_ID", desc = "资费ID", cons = ConsType.CT001, len = "", memo = "")
    private String prcId;

    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", desc = "资费名称", cons = ConsType.CT001, len = "", memo = "")
    private String prcName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", desc = "总优惠量", cons = ConsType.CT001, len = "", memo = "")
    private String total;

    @JSONField(serialize = false)
    private long longTotal;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", desc = "已使用量", cons = ConsType.CT001, len = "", memo = "")
    private String used;

    @JSONField(serialize = false)
    private long longUsed;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", desc = "剩余量", cons = ConsType.CT001, len = "", memo = "")
    private String remain;

    @JSONField(serialize = false)
    private long longRemain;

    @JSONField(name = "UNIT")
    @ParamDesc(path = "UNIT", desc = "计量单位", cons = ConsType.CT001, len = "", memo = "")
    private String unit;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", desc = "计量单位名称", cons = ConsType.CT001, len = "", memo = "")
    private String unitName;

    public String getGprsRegionType() {
        return gprsRegionType;
    }

    public void setGprsRegionType(String gprsRegionType) {
        this.gprsRegionType = gprsRegionType;
    }

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
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
        return "TransFreeEntity{" +
                "gprsRegionType='" + gprsRegionType + '\'' +
                ", prcId='" + prcId + '\'' +
                ", prcName='" + prcName + '\'' +
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
