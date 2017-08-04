package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/12/24.
 */
public class PhoneBillEntity implements Serializable {
    @JSONField(name = "PHONE_NO")
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "")
    private String phoneNo;
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "帐户号码", memo = "")
    private long contractNo;
    @JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, type = "int", len = "6", desc = "查询帐期", memo = "YYYYMM")
    private int yearMonth;
    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "略")
    private long shouldPay;
    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "略")
    private long favourFee;
    @JSONField(name = "PAYED_PREPAY")
    @ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, type = "long", len = "14", desc = "划拨金额", memo = "略")
    private long payedPrepay;
    @JSONField(name = "PAYED_LATER")
    @ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, type = "long", len = "14", desc = "新交款金额", memo = "略")
    private long payedLater;
    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "欠费", memo = "略")
    private long oweFee;
    @JSONField(name = "DELAY_FEE")
    @ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "滞纳金费用", memo = "略")
    private long delayFee;
    @JSONField(name = "STATUS_NAME")
    @ParamDesc(path = "STATUS_NAME", cons = ConsType.CT001, type = "String", len = "20", desc = "帐单状态", memo = "略")
    private String statusName;
    @JSONField(name = "DETAIL_LIST")
    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.CT001, type = "complex", len = "", desc = "帐单按帐目项合并的明细列表", memo = "略")
    List<BillDispDetailEntity> detailList;

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
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

    public long getPayedPrepay() {
        return payedPrepay;
    }

    public void setPayedPrepay(long payedPrepay) {
        this.payedPrepay = payedPrepay;
    }

    public long getPayedLater() {
        return payedLater;
    }

    public void setPayedLater(long payedLater) {
        this.payedLater = payedLater;
    }

    public long getOweFee() {
        return oweFee;
    }

    public void setOweFee(long oweFee) {
        this.oweFee = oweFee;
    }

    public long getDelayFee() {
        return delayFee;
    }

    public void setDelayFee(long delayFee) {
        this.delayFee = delayFee;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public List<BillDispDetailEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<BillDispDetailEntity> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "PhoneBillEntity{" +
                "phoneNo='" + phoneNo + '\'' +
                ", contractNo=" + contractNo +
                ", yearMonth=" + yearMonth +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", payedPrepay=" + payedPrepay +
                ", payedLater=" + payedLater +
                ", oweFee=" + oweFee +
                ", delayFee=" + delayFee +
                ", statusName='" + statusName + '\'' +
                ", detailList=" + detailList +
                '}';
    }
}
