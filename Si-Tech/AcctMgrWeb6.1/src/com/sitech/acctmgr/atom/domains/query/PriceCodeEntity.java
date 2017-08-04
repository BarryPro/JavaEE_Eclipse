package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 二批代码数据实体
 *
 * @author Administrator
 */
public class PriceCodeEntity {

    @JSONField(name = "PRICE_CODE")
    @ParamDesc(path = "PRICE_CODE", cons = ConsType.CT001, type = "String", len = "4", desc = "资费代码", memo = "略")
    private String priceCode;

    @JSONField(name = "PRICE_NAME")
    @ParamDesc(path = "PRICE_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "资费名称", memo = "略")
    private String priceName;

    @JSONField(name = "PRICE_FEE")
    @ParamDesc(path = "PRICE_FEE", cons = ConsType.CT001, type = "double", len = "16", desc = "资费费用", memo = "单位：分")
    private long priceFee;

    @JSONField(name = "CHARGE_TYPE")
    @ParamDesc(path = "CHARGE_TYPE", cons = ConsType.CT001, type = "String", len = "1", desc = "费用类型", memo = "略")
    private String chargeType;

    @JSONField(name = "CHARGE_FLAG")
    @ParamDesc(path = "CHARGE_FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "费用标识", memo = "略")
    private String chargeFlag;

    @JSONField(name = "CHARGE_FLAG_NAME")
    @ParamDesc(path = "CHARGE_FLAG_NAME", cons = ConsType.CT001, type = "String", len = "4", desc = "费用标识名称", memo = "略")
    private String chargeFlagName;

    public String getPriceCode() {
        return priceCode;
    }

    public void setPriceCode(String priceCode) {
        this.priceCode = priceCode;
    }

    public String getPriceName() {
        return priceName;
    }

    public void setPriceName(String priceName) {
        this.priceName = priceName;
    }

    public long getPriceFee() {
        return priceFee;
    }

    public void setPriceFee(long priceFee) {
        this.priceFee = priceFee;
    }

    public String getChargeType() {
        return chargeType;
    }

    public void setChargeType(String chargeType) {
        this.chargeType = chargeType;
    }

    public String getChargeFlag() {
        return chargeFlag;
    }

    public void setChargeFlag(String chargeFlag) {
        this.chargeFlag = chargeFlag;
    }

    public String getChargeFlagName() {
        return chargeFlagName;
    }

    public void setChargeFlagName(String chargeFlagName) {
        this.chargeFlagName = chargeFlagName;
    }

    @Override
    public String toString() {
        return "PriceCodeEntity{" +
                "priceCode='" + priceCode + '\'' +
                ", priceName='" + priceName + '\'' +
                ", priceFee=" + priceFee +
                ", chargeType='" + chargeType + '\'' +
                ", chargeFlag='" + chargeFlag + '\'' +
                ", chargeFlagName='" + chargeFlagName + '\'' +
                '}';
    }

}
