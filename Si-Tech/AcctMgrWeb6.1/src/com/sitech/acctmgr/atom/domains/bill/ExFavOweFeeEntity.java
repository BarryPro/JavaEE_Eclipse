package com.sitech.acctmgr.atom.domains.bill;

/**
 * Created by wangyla on 2016/8/22.
 */
public class ExFavOweFeeEntity {
    private long shouldPay;
    private long favourFee;
    private long realFee;
    private long exFavourFee;

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

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public long getExFavourFee() {
        return exFavourFee;
    }

    public void setExFavourFee(long exFavourFee) {
        this.exFavourFee = exFavourFee;
    }

    @Override
    public String toString() {
        return "ExFavOweFeeEntity{" +
                "exFavourFee=" + exFavourFee +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", shouldPay=" + shouldPay +
                '}';
    }
}
