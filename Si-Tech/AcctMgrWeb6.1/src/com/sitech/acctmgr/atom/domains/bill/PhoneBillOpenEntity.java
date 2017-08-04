package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/5.
 */
public class PhoneBillOpenEntity implements Serializable {

    @JSONField(name = "InBill")
    @ParamDesc(path = "InBill", cons = ConsType.CT001, type = "String", len = "2", desc = "帐单话费月份", memo = "MM")
    private String billMonth;

    @JSONField(serialize = false)
    private int yearMonth;

    @JSONField(name = "BillCycleStartDate")
    @ParamDesc(path = "BillCycleStartDate", cons = ConsType.CT001, type = "int", len = "6", desc = "本月帐期的起始日", memo = "YYYYMMDD")
    private int billBegin;

    @JSONField(name = "BillCycleEndDate")
    @ParamDesc(path = "BillCycleEndDate", cons = ConsType.CT001, type = "int", len = "6", desc = "本月帐期结束日", memo = "YYYYMMDD")
    private int billEnd;

    @JSONField(serialize = false)
    private long totalShould;

    @JSONField(serialize = false)
    private long totalFavour;

    @JSONField(serialize = false)
    private long totalReal;

    @JSONField(name = "ToatlBill")
    @ParamDesc(path = "ToatlBill", cons = ConsType.CT001, type = "string", len = "12", desc = "帐单话费总额", memo = "单位：元，精确到分")
    private String billFee;

    @JSONField(name = "BillMaterial")
    @ParamDesc(path = "BillMaterial", cons = ConsType.PLUS, type = "complex", len = "", desc = "帐单资料条目", memo = "YYYYMMDD")
    private List<BillOpenLv1Entity> billList;

    public String getBillMonth() {
        return billMonth;
    }

    public void setBillMonth(String billMonth) {
        this.billMonth = billMonth;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public int getBillBegin() {
        return billBegin;
    }

    public void setBillBegin(int billBegin) {
        this.billBegin = billBegin;
    }

    public int getBillEnd() {
        return billEnd;
    }

    public void setBillEnd(int billEnd) {
        this.billEnd = billEnd;
    }

    public long getTotalShould() {
        return totalShould;
    }

    public void setTotalShould(long totalShould) {
        this.totalShould = totalShould;
    }

    public long getTotalFavour() {
        return totalFavour;
    }

    public void setTotalFavour(long totalFavour) {
        this.totalFavour = totalFavour;
    }

    public long getTotalReal() {
        return totalReal;
    }

    public void setTotalReal(long totalReal) {
        this.totalReal = totalReal;
    }

    public String getBillFee() {
        return billFee;
    }

    public void setBillFee(String billFee) {
        this.billFee = billFee;
    }

    public List<BillOpenLv1Entity> getBillList() {
        return billList;
    }

    public void setBillList(List<BillOpenLv1Entity> billList) {
        this.billList = billList;
    }
}
