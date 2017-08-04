package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.atom.domains.free.MzoneFreeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/25.
 */
public class SMzoneFreeQueryOutDTO extends CommonOutDTO{
    @ParamDesc(path = "FREE_LIST", desc = "动感地带优惠信息列表", type = "complex", len = "", cons = ConsType.STAR, memo = "list")
    private List<MzoneFreeEntity> freeList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("freeList"), freeList);
        return result;
    }

    public List<MzoneFreeEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<MzoneFreeEntity> freeList) {
        this.freeList = freeList;
    }
}
