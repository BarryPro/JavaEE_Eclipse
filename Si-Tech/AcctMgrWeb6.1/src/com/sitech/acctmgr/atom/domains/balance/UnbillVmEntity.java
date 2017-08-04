package com.sitech.acctmgr.atom.domains.balance;

/**
 * 未出帐虚拟销账记录数据实体
 * Created by wangyla on 2017/3/1.
 */
public class UnbillVmEntity {
    private long conNo;
    private long idNo;
    private String phoneNo;
    private long balanceId;
    private String payType;
    private String specialFlag;
    private long curBalance;
    private long wrtoffFee;
    private String acctItemCode;
    private long shouldPay;
    private long favourFee;

    public long getConNo() {
        return conNo;
    }

    public void setConNo(long conNo) {
        this.conNo = conNo;
    }

    public long getIdNo() {
        return idNo;
    }

    public void setIdNo(long idNo) {
        this.idNo = idNo;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public long getBalanceId() {
        return balanceId;
    }

    public void setBalanceId(long balanceId) {
        this.balanceId = balanceId;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getSpecialFlag() {
        return specialFlag;
    }

    public void setSpecialFlag(String specialFlag) {
        this.specialFlag = specialFlag;
    }

    public long getCurBalance() {
        return curBalance;
    }

    public void setCurBalance(long curBalance) {
        this.curBalance = curBalance;
    }

    public long getWrtoffFee() {
        return wrtoffFee;
    }

    public void setWrtoffFee(long wrtoffFee) {
        this.wrtoffFee = wrtoffFee;
    }

    public String getAcctItemCode() {
        return acctItemCode;
    }

    public void setAcctItemCode(String acctItemCode) {
        this.acctItemCode = acctItemCode;
    }

    public long getShouldPay() {
        return shouldPay;
    }

    public void setShouldPay(long shouldPay) {
        this.shouldPay = shouldPay;
    }

    public long getFavourFee() {
        return favourFee;
    }

    public void setFavourFee(long favourFee) {
        this.favourFee = favourFee;
    }

    @Override
    public String toString() {
        return "UnbillVmEntity{" +
                "conNo=" + conNo +
                ", idNo=" + idNo +
                ", phoneNo='" + phoneNo + '\'' +
                ", balanceId=" + balanceId +
                ", payType='" + payType + '\'' +
                ", specialFlag='" + specialFlag + '\'' +
                ", curBalance=" + curBalance +
                ", wrtoffFee=" + wrtoffFee +
                ", acctItemCode='" + acctItemCode + '\'' +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                '}';
    }
}
