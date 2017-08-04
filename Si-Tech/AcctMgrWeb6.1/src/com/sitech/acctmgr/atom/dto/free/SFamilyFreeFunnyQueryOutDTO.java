package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.atom.domains.free.FamilyFunnyDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/25.
 */
public class SFamilyFreeFunnyQueryOutDTO extends CommonOutDTO{

    @ParamDesc(path = "FREE_LIST", desc = "家庭优惠显性展示列表", cons = ConsType.STAR, len ="", type = "complex", memo="List")
    private List<FamilyFunnyDispEntity> freeList;


    @Override
    public MBean encode(){
        MBean result = super.encode();
        result.setRoot(getPathByProperName("freeList"), freeList);
        return result;
    }

    public List<FamilyFunnyDispEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<FamilyFunnyDispEntity> freeList) {
        this.freeList = freeList;
    }
}
