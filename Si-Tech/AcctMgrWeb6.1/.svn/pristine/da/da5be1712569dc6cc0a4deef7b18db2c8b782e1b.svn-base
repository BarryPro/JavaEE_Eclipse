package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 用途：流量账单实体
 * Created by wangyla on 2016/7/14.
 */
public class TrafficBillEntity implements Serializable {
    @JSONField(name = "BUSI_CODE")
    private String busiCode;

    @JSONField(name = "PROD_PRCID_NAME")
    @ParamDesc(path = "PROD_PRCID_NAME", desc = "套餐资费名称", cons = ConsType.CT001, len = "60", type = "String", memo = "")
    private String prodPrcIdName;

    @JSONField(name = "MONTH_FEE")
    @ParamDesc(path = "MONTH_FEE", desc = "套餐月租费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long monthFee;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", desc = "套餐总优惠量", cons = ConsType.CT001, len = "14", type = "String", memo = "与UNIT_NAME节点对应")
    private String total;

    @JSONField(name = "CURRENT")
    @ParamDesc(path = "CURRENT", desc = "套餐已使用优惠", cons = ConsType.CT001, len = "60", type = "String", memo = "")
    private String current;

    @JSONField(name = "UNIT")
    @ParamDesc(path = "UNIT", desc = "计量单位标识", cons = ConsType.CT001, len = "1", type = "String", memo = "1：MB， 2：分钟")
    private String unit;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", desc = "计量单位名称", cons = ConsType.CT001, len = "10", type = "String", memo = "")
    private String unitName;

    @JSONField(name = "PERCENT")
    @ParamDesc(path = "PERCENT", desc = "使用流量占比", cons = ConsType.CT001, len = "10", type = "String", memo = "")
    private String percent;

    @JSONField(name = "SHARE_FLAG")
    @ParamDesc(path = "SHARE_FLAG", desc = "套餐多人共享标识", cons = ConsType.CT001, len = "1", type = "String", memo = "Y：多人共享；N：非多人共享")
    private String shareFlag;

    public String getBusiCode() {
        return busiCode;
    }

    public void setBusiCode(String busiCode) {
        this.busiCode = busiCode;
    }

    public String getProdPrcIdName() {
        return prodPrcIdName;
    }

    public void setProdPrcIdName(String prodPrcIdName) {
        this.prodPrcIdName = prodPrcIdName;
    }

    public long getMonthFee() {
        return monthFee;
    }

    public void setMonthFee(long monthFee) {
        this.monthFee = monthFee;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) {
        this.current = current;
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

    public String getPercent() {
        return percent;
    }

    public void setPercent(String percent) {
        this.percent = percent;
    }

    public String getShareFlag() {
        return shareFlag;
    }

    public void setShareFlag(String shareFlag) {
        this.shareFlag = shareFlag;
    }

    @Override
    public String toString() {
        return "TrafficBillEntity{" +
                "busiCode='" + busiCode + '\'' +
                ", prodPrcIdName='" + prodPrcIdName + '\'' +
                ", monthFee=" + monthFee +
                ", total='" + total + '\'' +
                ", current='" + current + '\'' +
                ", unit='" + unit + '\'' +
                ", unitName='" + unitName + '\'' +
                ", percent='" + percent + '\'' +
                ", shareFlag='" + shareFlag + '\'' +
                '}';
    }
}
