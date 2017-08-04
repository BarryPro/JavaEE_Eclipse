package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/11/5.
 */
public class SpDispEntity implements Serializable {
    @JSONField(name = "TOTAL_FEE")
    @ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001,len = "", type = "",desc = "SP费用总和",memo = "")
    private long totalFee;

    @JSONField(name = "SP_LIST")
    @ParamDesc(path = "SP_LIST", cons = ConsType.CT001,len = "", type = "complex",desc = "SP明细列表",memo = "")
    private List<SpDetailBill> spList;

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

    public List<SpDetailBill> getSpList() {
        return spList;
    }

    public void setSpList(List<SpDetailBill> spList) {
        this.spList = spList;
    }

    @Override
    public String toString() {
        return "SpDispEntity{" +
                "totalFee=" + totalFee +
                ", spList=" + spList +
                '}';
    }
}
