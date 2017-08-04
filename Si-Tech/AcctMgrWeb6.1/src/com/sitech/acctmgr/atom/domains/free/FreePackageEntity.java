package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/6.
 * 能力开放平台套餐使用节点
 */
public class FreePackageEntity implements Serializable {

    @JSONField(name = "InPlanQry")
    @ParamDesc(path = "InPlanQry", cons = ConsType.PLUS, type = "complex", len = "256", desc = "套餐内资源使用信息", memo = "列表")
    private List<FreeInPackageEntity> inList;

    @JSONField(name = "OutPlanQry")
    @ParamDesc(path = "OutPlanQry", cons = ConsType.PLUS, type = "complex", len = "256", desc = "套餐外计费资源信息", memo = "列表")
    private List<FreeOutPackageEntity> outList;

    public List<FreeInPackageEntity> getInList() {
        return inList;
    }

    public void setInList(List<FreeInPackageEntity> inList) {
        this.inList = inList;
    }

    public List<FreeOutPackageEntity> getOutList() {
        return outList;
    }

    public void setOutList(List<FreeOutPackageEntity> outList) {
        this.outList = outList;
    }

    @Override
    public String toString() {
        return "FreePackageEntity{" +
                "inList=" + inList +
                ", outList=" + outList +
                '}';
    }
}
