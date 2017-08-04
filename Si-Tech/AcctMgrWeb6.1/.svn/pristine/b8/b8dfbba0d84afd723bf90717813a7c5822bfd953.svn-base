package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/7.
 * 二级资源信息实体（除能力平台外不建议使用此实体）
 */
public class FreeDetailLv2InEntity implements Serializable {

    /*语音资源；短信资源；GPRS资源；WLAN资源；彩信资源；*/
    @JSONField(name = "SecResourcesName")
    @ParamDesc(path = "SecResourcesName", cons = ConsType.CT001, type = "string", len = "256", desc = "资源信息名称(二级资源名称)", memo = "")
    private String resName;

    @JSONField(name = "ResourcesLeftInfo")
    @ParamDesc(path = "ResourcesLeftInfo", cons = ConsType.PLUS, type = "complex", len = "", desc = "二级资源信息内容", memo = "列表")
    private List<FreeDetailLv3InEntity> freeList;

    public String getResName() {
        return resName;
    }

    public void setResName(String resName) {
        this.resName = resName;
    }

    public List<FreeDetailLv3InEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<FreeDetailLv3InEntity> freeList) {
        this.freeList = freeList;
    }
}
