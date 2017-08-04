package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/11/4.
 * 帐户附录页查询中，帐户入帐明细展示数据实体
 */
public class ConDetailAppendixDispEntity implements Serializable {

    @JSONField(name = "LAST_PREPAY")
    @ParamDesc(path = "LAST_PREPAY", cons = ConsType.CT001, type = "long", len = "", desc = "本期期初余额", memo = "")
    private long lastPrepay;

    @JSONField(name = "INCOME")
    @ParamDesc(path = "INCOME", cons = ConsType.CT001, type = "long", len = "", desc = "本期收入", memo = "")
    private long income;

    @JSONField(name = "OUT_FEE")
    @ParamDesc(path = "OUT_FEE", cons = ConsType.CT001, type = "long", len = "", desc = "支出费用", memo = "")
    private long outFee;

    @JSONField(name = "CUR_BALANCE")
    @ParamDesc(path = "CUR_BALANCE", cons = ConsType.CT001, type = "long", len = "", desc = "本期期末余额", memo = "")
    private long curBalance;

    @JSONField(name = "INCOME_LIST")
    @ParamDesc(path = "INCOME_LIST", cons = ConsType.CT001, type = "complex", len = "", desc = "入帐明细列表", memo = "")
    private List<IncomeBill> incomeList;

    public long getLastPrepay() {
        return lastPrepay;
    }

    public void setLastPrepay(long lastPrepay) {
        this.lastPrepay = lastPrepay;
    }

    public long getIncome() {
        return income;
    }

    public void setIncome(long income) {
        this.income = income;
    }

    public long getOutFee() {
        return outFee;
    }

    public void setOutFee(long outFee) {
        this.outFee = outFee;
    }

    public long getCurBalance() {
        return curBalance;
    }

    public void setCurBalance(long curBalance) {
        this.curBalance = curBalance;
    }

    public List<IncomeBill> getIncomeList() {
        return incomeList;
    }

    public void setIncomeList(List<IncomeBill> incomeList) {
        this.incomeList = incomeList;
    }
}
