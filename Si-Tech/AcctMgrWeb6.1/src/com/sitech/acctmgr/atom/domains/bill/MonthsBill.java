package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

public class MonthsBill implements Serializable {
    @JSONField(name = "PCAS_04_DATE")
    @ParamDesc(
            path = "PCAS_04_DATE",
            len = "6",
            desc = "帐务年月",
            cons = ConsType.CT001,
            memo = "YYYYMM",
            type = "int"
    )
    private int yearMonth;

    @JSONField(name = "PCAS_04_FEE")
    @ParamDesc(
            path = "PCAS_04_FEE",
            len = "",
            desc = "总金额",
            cons = ConsType.CT001,
            memo = "单位：分",
            type = "long"
    )
    private long fee;

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public long getFee() {
        return fee;
    }

    public void setFee(long fee) {
        this.fee = fee;
    }

}
