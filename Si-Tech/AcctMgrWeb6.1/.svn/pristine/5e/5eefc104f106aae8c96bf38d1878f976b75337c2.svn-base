package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/11/5.
 * 帐单附录页优惠信息展示实体
 */
public class Free2DispEntity implements Serializable{
    @JSONField(name = "PROD_PRC_NAME")
    @ParamDesc(path = "PROD_PRC_NAME", cons = ConsType.CT001, len = "120", type = "string", desc = "套餐名称", memo = "")
    private String prodPrcName;

    @JSONField(name = "BUSI_NAME")
    @ParamDesc(path = "BUSI_NAME", cons = ConsType.CT001, len = "24", type = "string", desc = "业务类型名称", memo = "如：GPRS业务、语音业务等")
    private String busiName;

    @JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, len = "6", type = "string", desc = "年月", memo = "YYYYMM")
    private String yearMonth;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001, len = "8", type = "string", desc = "总赠送量", memo = "")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001, len = "", type = "string", desc = "已使用", memo = "")
    private String used;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", cons = ConsType.CT001, len = "", type = "string", desc = "剩余量", memo = "")
    private String remain;

    @JSONField(name = "FREE_LAST_TOTAL")
    @ParamDesc(path = "FREE_LAST_TOTAL", cons = ConsType.QUES, len = "40", type = "string", desc = "结转流量总量", memo = "")
    private String lastTotal;

    @JSONField(name = "FREE_LAST_USED")
    @ParamDesc(path = "FREE_LAST_USED", cons = ConsType.QUES, len = "40", type = "string", desc = "结转流量使用量", memo = "")
    private String lastUsed;

    @JSONField(name = "FREE_LAST_REMAIN")
    @ParamDesc(path = "FREE_LAST_REMAIN", cons = ConsType.QUES, len = "40", type = "string", desc = "结转流量剩余", memo = "")
    private String lastRemain;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", cons = ConsType.CT001, len = "10", type = "string", desc = "单位", memo = "如：KB、分钟、等等")
    private String unitName;

    public String getProdPrcName() {
        return prodPrcName;
    }

    public void setProdPrcName(String prodPrcName) {
        this.prodPrcName = prodPrcName;
    }

    public String getBusiName() {
        return busiName;
    }

    public void setBusiName(String busiName) {
        this.busiName = busiName;
    }

    public String getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(String yearMonth) {
        this.yearMonth = yearMonth;
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

    public String getRemain() {
        return remain;
    }

    public void setRemain(String remain) {
        this.remain = remain;
    }

    public String getLastTotal() {
        return lastTotal;
    }

    public void setLastTotal(String lastTotal) {
        this.lastTotal = lastTotal;
    }

    public String getLastUsed() {
        return lastUsed;
    }

    public void setLastUsed(String lastUsed) {
        this.lastUsed = lastUsed;
    }

    public String getLastRemain() {
        return lastRemain;
    }

    public void setLastRemain(String lastRemain) {
        this.lastRemain = lastRemain;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    @Override
    public String toString() {
        return "Free2DispEntity{" +
                "prodPrcName='" + prodPrcName + '\'' +
                ", busiName='" + busiName + '\'' +
                ", yearMonth='" + yearMonth + '\'' +
                ", total='" + total + '\'' +
                ", used='" + used + '\'' +
                ", remain='" + remain + '\'' +
                ", lastTotal='" + lastTotal + '\'' +
                ", lastUsed='" + lastUsed + '\'' +
                ", lastRemain='" + lastRemain + '\'' +
                ", unitName='" + unitName + '\'' +
                '}';
    }
}
