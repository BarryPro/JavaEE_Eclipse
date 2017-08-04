package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/5.
 */
public class BillOpenLv1Entity implements Serializable {
    @JSONField(name = "BillEntries")
    @ParamDesc(path = "BillEntries", cons = ConsType.CT001, type = "String", len = "2", desc = "帐单条目编码", memo = "01~06，09：其他")
    private String lv1ItemId;

    @JSONField(name = "BillEntriesValue")
    @ParamDesc(path = "BillEntriesValue", cons = ConsType.CT001, type = "String", len = "12", desc = "帐单条目值", memo = "单位：元，精确到分")
    private String realFee;

    @JSONField(serialize = false)
    private long longRealFee;

    @JSONField(name = "ThirdBillMaterialInfo")
    @ParamDesc(path = "ThirdBillMaterialInfo", cons = ConsType.PLUS, type = "complex", len = "", desc = "三级科目条目信息", memo = "列表")
    private List<BillOpenLv3Entity> billList;

    public String getLv1ItemId() {
        return lv1ItemId;
    }

    public void setLv1ItemId(String lv1ItemId) {
        this.lv1ItemId = lv1ItemId;
    }

    public String getRealFee() {
        return realFee;
    }

    public void setRealFee(String realFee) {
        this.realFee = realFee;
    }

    public long getLongRealFee() {
        return longRealFee;
    }

    public void setLongRealFee(long longRealFee) {
        this.longRealFee = longRealFee;
    }

    public List<BillOpenLv3Entity> getBillList() {
        return billList;
    }

    public void setBillList(List<BillOpenLv3Entity> billList) {
        this.billList = billList;
    }

    @Override
    public String toString() {
        return "BillOpenLv1Entity{" +
                "lv1ItemId='" + lv1ItemId + '\'' +
                ", realFee='" + realFee + '\'' +
                ", longRealFee=" + longRealFee +
                ", billList=" + billList +
                '}';
    }
}
