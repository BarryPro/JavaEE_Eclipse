/**
 * File：CollPhoneBillDetailEntity.java
 * <p/>
 * Version：
 * Date：2015-3-16
 * Copyright Clarify:
 */

package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * @Description: 用户在帐户下的托收单明细信息
 * @author: wangyla
 * @version:
 * @createTime: 2015-3-16 下午2:43:51
 */

public class CollPhoneBillDetailEntity implements Serializable {
    private static final long serialVersionUID = -5267313900861589707L;
    @JSONField(name = "PHONE_NO")
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", desc = "手机号码", type = "String", memo = "略")
    String phoneNo;
    @JSONField(name = "CUST_NAME")
    @ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, len = "100", desc = "客户名称", type = "String", memo = "略")
    String custName;
    @JSONField(name = "ITEM_NAME")
    @ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, len = "10", desc = "一级帐目项名称", type = "String", memo = "略")
    String itemName;
    @JSONField(name = "FEE")
    @ParamDesc(path = "FEE", cons = ConsType.CT001, len = "", desc = "费用", type = "long", memo = "实收费用")
    long fee;

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public long getFee() {
        return fee;
    }

    public void setFee(long fee) {
        this.fee = fee;
    }

    @Override
    public String toString() {
        return "CollPhoneBillDetailEntity{" +
                "phoneNo='" + phoneNo + '\'' +
                ", custName='" + custName + '\'' +
                ", itemName='" + itemName + '\'' +
                ", fee=" + fee +
                '}';
    }
}
