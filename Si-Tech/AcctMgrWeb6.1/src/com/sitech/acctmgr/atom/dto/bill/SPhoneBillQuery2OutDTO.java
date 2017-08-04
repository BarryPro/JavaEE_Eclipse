package com.sitech.acctmgr.atom.dto.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.FeeCodeBillEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/4/12.
 */
public class SPhoneBillQuery2OutDTO extends CommonOutDTO {
    @ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "客户名称", memo = "略")
    private String custName;

    @ParamDesc(path = "STATUS_NAME", cons = ConsType.CT001, type = "String", len = "60", desc = "欠费状态", memo = "略")
    private String statusName;

    @ParamDesc(path = "BILL_BEGIN", cons = ConsType.CT001, type = "int", len = "8", desc = "账期开始日", memo = "略")
    private int billBegin;

    @ParamDesc(path = "BILL_END", cons = ConsType.CT001, type = "int", len = "8", desc = "账期结束日", memo = "略")
    private int billEnd;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "应收金额", memo = "略")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "优惠金额", memo = "略")
    private long favourFee;

    @JSONField(name = "OWE_FEE")
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "欠费金额", memo = "略")
    private long oweFee;

    @JSONField(name = "DELAY_FEE")
    @ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "滞纳金费用", memo = "略")
    private long delayFee;

    @JSONField(name = "DETAIL_LIST")
    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.CT001, type = "complex", len = "", desc = "一级帐目项费用列表", memo = "略")
    private List<FeeCodeBillEntity> detailList;

    @Override
    public MBean encode() {

        MBean bean = super.encode();
        bean.setRoot(getPathByProperName("custName"), custName);
        bean.setRoot(getPathByProperName("statusName"), statusName);
        bean.setRoot(getPathByProperName("billBegin"), billBegin);
        bean.setRoot(getPathByProperName("billEnd"), billEnd);
        bean.setRoot(getPathByProperName("shouldPay"), shouldPay);
        bean.setRoot(getPathByProperName("favourFee"), favourFee);
        bean.setRoot(getPathByProperName("oweFee"), oweFee);
        bean.setRoot(getPathByProperName("delayFee"), delayFee);
        bean.setRoot(getPathByProperName("detailList"), detailList);

        return bean;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
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

    public List<FeeCodeBillEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FeeCodeBillEntity> detailList) {
        this.detailList = detailList;
    }
}
