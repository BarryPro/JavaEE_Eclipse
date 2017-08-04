package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/11/23.
 */
public class GrpBillDispEntity implements Serializable {

    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", cons = ConsType.CT001, type = "String", len = "64", desc = "集团产品主定价名称", memo = "")
    private String prcName;

    @JSONField(name = "GRP_CONTRACT_NO")
    @ParamDesc(path = "GRP_CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "集团产品对应帐户号码", memo = "")
    private long grpContractNo;

    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "long", len = "14", desc = "集团产品应收总额", memo = "单位：分")
    private long shouldPay;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "集团产品优惠金额", memo = "单位：分")
    private long favourFee;

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "集团产品实应收", memo = "略")
    private long realFee;

    @JSONField(name = "DETAIL_LIST")
    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.CT001, type = "complex", len = "", desc = "产品下帐单组成明细", memo = "按帐目项合并后的费用列表")
    private List<BillDispDetailEntity> detailList;

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
    }

    public long getGrpContractNo() {
        return grpContractNo;
    }

    public void setGrpContractNo(long grpContractNo) {
        this.grpContractNo = grpContractNo;
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

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public List<BillDispDetailEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<BillDispDetailEntity> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "GrpBillDispEntity{" +
                "prcName='" + prcName + '\'' +
                ", grpContractNo=" + grpContractNo +
                ", shouldPay=" + shouldPay +
                ", favourFee=" + favourFee +
                ", realFee=" + realFee +
                ", detailList=" + detailList +
                '}';
    }
}
