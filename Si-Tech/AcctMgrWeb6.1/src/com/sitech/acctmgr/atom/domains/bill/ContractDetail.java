package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ContractDetail implements Serializable {

    @JSONField(serialize = false)
    @ParamDesc(path = "PRESENT_FLAG", desc = "费用类型", memo = "0:客户付费类；1：移动赠送类", len = "1", cons = ConsType.QUES, type = "String")
    private String presentFlag;

    @ParamDesc(path = "PCAS_07_01", desc = "帐户名称", memo = "", len = "60", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_01")
    private String conName;

    @ParamDesc(path = "PCAS_07_02", desc = "期初余额", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_02")
    private long lastBalance; // 期初余额

    @ParamDesc(path = "PCAS_07_03", desc = "本期收入", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_03")
    private long income;

    @ParamDesc(path = "PCAS_07_04", desc = "本期返还", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_04")
    private long returnFee;

    @ParamDesc(path = "PCAS_07_05", desc = "本期退费", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_05")
    private long backFee;

    @ParamDesc(path = "PCAS_07_06", desc = "本期可用", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_06")
    private long useableFee;

    @ParamDesc(path = "PCAS_07_07", desc = "消费支出", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_07")
    private long outgo;

    @ParamDesc(path = "PCAS_07_08", desc = "其他支出", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_08")
    private long otherOutgo;

    @ParamDesc(path = "PCAS_07_09", desc = "当前余额", memo = "单位：分", len = "14", cons = ConsType.CT001, type = "long")
    @JSONField(name = "PCAS_07_09")
    private long currentBalance;

    public String getPresentFlag() {
        return presentFlag;
    }

    public void setPresentFlag(String presentFlag) {
        this.presentFlag = presentFlag;
    }

    public String getConName() {
        return conName;
    }

    public void setConName(String conName) {
        this.conName = conName;
    }

    public long getLastBalance() {
        return lastBalance;
    }

    public void setLastBalance(long lastBalance) {
        this.lastBalance = lastBalance;
    }

    public long getIncome() {
        return income;
    }

    public void setIncome(long income) {
        this.income = income;
    }

    public long getReturnFee() {
        return returnFee;
    }

    public void setReturnFee(long returnFee) {
        this.returnFee = returnFee;
    }

    public long getBackFee() {
        return backFee;
    }

    public void setBackFee(long backFee) {
        this.backFee = backFee;
    }

    public long getUseableFee() {
        return useableFee;
    }

    public void setUseableFee(long useableFee) {
        this.useableFee = useableFee;
    }

    public long getOutgo() {
        return outgo;
    }

    public void setOutgo(long outgo) {
        this.outgo = outgo;
    }

    public long getOtherOutgo() {
        return otherOutgo;
    }

    public void setOtherOutgo(long otherOutgo) {
        this.otherOutgo = otherOutgo;
    }

    public long getCurrentBalance() {
        return currentBalance;
    }

    public void setCurrentBalance(long currentBalance) {
        this.currentBalance = currentBalance;
    }

    @Override
    public String toString() {
        return "ContractDetail{" +
                "presentFlag='" + presentFlag + '\'' +
                ", conName='" + conName + '\'' +
                ", lastBalance=" + lastBalance +
                ", income=" + income +
                ", returnFee=" + returnFee +
                ", backFee=" + backFee +
                ", useableFee=" + useableFee +
                ", outgo=" + outgo +
                ", otherOutgo=" + otherOutgo +
                ", currentBalance=" + currentBalance +
                '}';
    }

}
