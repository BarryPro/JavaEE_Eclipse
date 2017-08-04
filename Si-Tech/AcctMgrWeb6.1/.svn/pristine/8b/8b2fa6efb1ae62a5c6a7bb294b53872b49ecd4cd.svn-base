package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/6.
 */
public class FreeInPackageEntity implements Serializable {

    @JSONField(name = "planName")
    @ParamDesc(path = "planName", cons = ConsType.CT001, type = "string", len = "128", desc = "套餐名称", memo = "")
    private String prcName;

    @JSONField(name = "planID")
    @ParamDesc(path = "planID", cons = ConsType.CT001, type = "string", len = "10", desc = "套餐id", memo = "")
    private String prcId;

    @JSONField(name = "ValidDate")
    @ParamDesc(path = "ValidDate", cons = ConsType.QUES, type = "string", len = "14", desc = "套餐生效时间", memo = "YYYYMMDDHH24MISS BizCode为0000时此字段必须返回")
    private String effDate;

    @JSONField(name = "OutDate")
    @ParamDesc(path = "OutDate", cons = ConsType.QUES, type = "string", len = "14", desc = "套餐失效时间", memo = "YYYYMMDDHH24MISS")
    private String expDate;

    @JSONField(name = "ResourcesInfo")
    @ParamDesc(path = "ResourcesInfo", cons = ConsType.PLUS, type = "complex", len = "", desc = "套餐内资源信息项目", memo = "列表")
    private List<FreeDetailLv1InEntity> detailList;

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
    }

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getEffDate() {
        return effDate;
    }

    public void setEffDate(String effDate) {
        this.effDate = effDate;
    }

    public String getExpDate() {
        return expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public List<FreeDetailLv1InEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FreeDetailLv1InEntity> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "FreeInPackageEntity{" +
                "prcName='" + prcName + '\'' +
                ", prcId='" + prcId + '\'' +
                ", effDate='" + effDate + '\'' +
                ", expDate='" + expDate + '\'' +
                ", detailList=" + detailList +
                '}';
    }
}
