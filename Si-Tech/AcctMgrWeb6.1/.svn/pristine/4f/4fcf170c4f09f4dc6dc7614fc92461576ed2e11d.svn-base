package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/18.
 */
public class SFreeAllQueryOutDTO extends CommonOutDTO{

    @JSONField(name = "FREE_INFO")
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "优惠信息明细", memo = "list;子节点中流量节点为KB")
    private List<FreeDetailEntity> freeList;

    @JSONField(name = "OUT_TOTAL")
    @ParamDesc(path = "OUT_TOTAL", cons = ConsType.QUES, len = "", type = "String", desc = "套餐外GPRS流量总量", memo = "单位KB")
    private String outTotal;

    @Override
    public MBean encode() {
        MBean result = super.encode();

        result.setRoot(getPathByProperName("freeList"), freeList);
        result.setRoot(getPathByProperName("outTotal"), outTotal);
        return result;
    }

    public List<FreeDetailEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<FreeDetailEntity> freeList) {
        this.freeList = freeList;
    }

    public String getOutTotal() {
        return outTotal;
    }

    public void setOutTotal(String outTotal) {
        this.outTotal = outTotal;
    }
}
