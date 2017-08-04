package com.sitech.acctmgr.atom.domains.query;

/**
 * Created by wangyla on 2017/3/4.
 */
public class BillTotCodeEntity {
    private String regioCode;
    private String totalCode;
    private String orderCode;
    private String favourObject;
    private long favour1;
    private long favour2;
    private long favour3;

    public String getRegioCode() {
        return regioCode;
    }

    public void setRegioCode(String regioCode) {
        this.regioCode = regioCode;
    }

    public String getTotalCode() {
        return totalCode;
    }

    public void setTotalCode(String totalCode) {
        this.totalCode = totalCode;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getFavourObject() {
        return favourObject;
    }

    public void setFavourObject(String favourObject) {
        this.favourObject = favourObject;
    }

    public long getFavour1() {
        return favour1;
    }

    public void setFavour1(long favour1) {
        this.favour1 = favour1;
    }

    public long getFavour2() {
        return favour2;
    }

    public void setFavour2(long favour2) {
        this.favour2 = favour2;
    }

    public long getFavour3() {
        return favour3;
    }

    public void setFavour3(long favour3) {
        this.favour3 = favour3;
    }

    @Override
    public String toString() {
        return "BillTotCodeEntity{" +
                "regioCode='" + regioCode + '\'' +
                ", totalCode='" + totalCode + '\'' +
                ", orderCode='" + orderCode + '\'' +
                ", favourObject='" + favourObject + '\'' +
                ", favour1=" + favour1 +
                ", favour2=" + favour2 +
                ", favour3=" + favour3 +
                '}';
    }
}
