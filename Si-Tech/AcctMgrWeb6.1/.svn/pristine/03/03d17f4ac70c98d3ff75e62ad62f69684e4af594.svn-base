package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/6/7.
 */
public class FreeDetailLv2OutEntity implements Serializable {

    @JSONField(name = "classify")
    @ParamDesc(path = "classify", cons = ConsType.QUES, type = "string", len = "2", desc = "套餐外资源分类",
            memo = "当MealInfoUpCode 为04时，取值为，01：套餐外省内；02：套餐外国内；03：套餐外国际；04其他。当MealInfoUpCode 为05时，取值为：05")
    private String resClass;

    @JSONField(name = "UsageAmount")
    @ParamDesc(path = "UsageAmount", cons = ConsType.QUES, type = "string", len = "12", desc = "套餐外资源使用量", memo = "")
    private String used;

    @JSONField(name = "Unit")
    @ParamDesc(path = "Unit", cons = ConsType.QUES, type = "string", len = "2", desc = "资源单位", memo = "01：分钟；02：条数；03：KB")
    private String unit;

    @JSONField(name = "charging")
    @ParamDesc(path = "charging", cons = ConsType.QUES, type = "string", len = "10", desc = "计费金额", memo = "单位：分（保留小数点后两位）")
    private String chargeFee;

    public String getResClass() {
        return resClass;
    }

    public void setResClass(String resClass) {
        this.resClass = resClass;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getChargeFee() {
        return chargeFee;
    }

    public void setChargeFee(String chargeFee) {
        this.chargeFee = chargeFee;
    }

    @Override
    public String toString() {
        return "FreeDetailLv2OutEntity{" +
                "resClass='" + resClass + '\'' +
                ", used='" + used + '\'' +
                ", unit='" + unit + '\'' +
                ", chargeFee='" + chargeFee + '\'' +
                '}';
    }
}
