package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/7/14.
 */
public class CarryOverGPRSEntity implements Serializable{

    @JSONField(name = "PRODUCT_NAME")
    @ParamDesc(path = "PRODUCT_NAME", len = "60", cons = ConsType.CT001, type = "String", desc = "产品名称", memo = "")
    private String productName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", len = "14", cons = ConsType.CT001, type = "String", desc = "结转总量", memo = "单位：MB")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", len = "14", cons = ConsType.CT001, type = "String", desc = "结转使用量", memo = "单位：MB")
    private String used;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", len = "5", cons = ConsType.CT001, type = "String", desc = "单位名称", memo = "单位名称：MB")
    private String unitName;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

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

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    @Override
    public String toString() {
        return "CarryOverGPRSEntity{" +
                "productName='" + productName + '\'' +
                ", total='" + total + '\'' +
                ", used='" + used + '\'' +
                ", unitName='" + unitName + '\'' +
                '}';
    }

}
