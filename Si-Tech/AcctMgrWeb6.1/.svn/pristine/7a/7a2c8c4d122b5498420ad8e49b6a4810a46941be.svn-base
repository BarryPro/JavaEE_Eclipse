package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.MonthsBill;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class QrySixBillOutDTO extends CommonOutDTO {

    @ParamDesc(path = "MONTH_1", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill1 = null;

    @ParamDesc(path = "MONTH_2", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill2 = null;

    @ParamDesc(path = "MONTH_3", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill3 = null;

    @ParamDesc(path = "MONTH_4", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill4 = null;

    @ParamDesc(path = "MONTH_5", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill5 = null;

    @ParamDesc(path = "MONTH_6", type = "compx", len = "", desc = "费用信息", memo = "非List", cons = ConsType.CT001)
    private MonthsBill monthsBill6 = null;

    @ParamDesc(path = "TOTAL_FEE", type = "long", len = "", desc = "6个月的总费用", memo = "单位：分", cons = ConsType.CT001)
    private long totalFee;

    @Override
    public MBean encode() {
        MBean mbean = super.encode();
        mbean.setRoot(getPathByProperName("monthsBill1"), monthsBill1);
        mbean.setRoot(getPathByProperName("monthsBill2"), monthsBill2);
        mbean.setRoot(getPathByProperName("monthsBill3"), monthsBill3);
        mbean.setRoot(getPathByProperName("monthsBill4"), monthsBill4);
        mbean.setRoot(getPathByProperName("monthsBill5"), monthsBill5);
        mbean.setRoot(getPathByProperName("monthsBill6"), monthsBill6);
        mbean.setRoot(getPathByProperName("totalFee"), totalFee);
        return mbean;
    }

    public MonthsBill getMonthsBill1() {
        return monthsBill1;
    }

    public void setMonthsBill1(MonthsBill monthsBill1) {
        this.monthsBill1 = monthsBill1;
    }

    public MonthsBill getMonthsBill2() {
        return monthsBill2;
    }

    public void setMonthsBill2(MonthsBill monthsBill2) {
        this.monthsBill2 = monthsBill2;
    }

    public MonthsBill getMonthsBill3() {
        return monthsBill3;
    }

    public void setMonthsBill3(MonthsBill monthsBill3) {
        this.monthsBill3 = monthsBill3;
    }

    public MonthsBill getMonthsBill4() {
        return monthsBill4;
    }

    public void setMonthsBill4(MonthsBill monthsBill4) {
        this.monthsBill4 = monthsBill4;
    }

    public MonthsBill getMonthsBill5() {
        return monthsBill5;
    }

    public void setMonthsBill5(MonthsBill monthsBill5) {
        this.monthsBill5 = monthsBill5;
    }

    public MonthsBill getMonthsBill6() {
        return monthsBill6;
    }

    public void setMonthsBill6(MonthsBill monthsBill6) {
        this.monthsBill6 = monthsBill6;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

}
