package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/6.
 */
public class FreeOutPackageEntity implements Serializable {
    @JSONField(name = "MealInfoUpCode")
    @ParamDesc(path = "MealInfoUpCode", cons = ConsType.CT001, type = "string", len = "2", desc = "资源名称编码", memo = "04：GPRS资源;05：WLAN资源")
    private String resCode;

    @JSONField(name = "MealInfoUpSource")
    @ParamDesc(path = "MealInfoUpSource", cons = ConsType.PLUS, type = "complex", len = "", desc = "套餐外计费资源使用信息", memo = "列表")
    private List<FreeDetailLv2OutEntity> detailList;

    public String getResCode() {
        return resCode;
    }

    public void setResCode(String resCode) {
        this.resCode = resCode;
    }

    public List<FreeDetailLv2OutEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FreeDetailLv2OutEntity> detailList) {
        this.detailList = detailList;
    }
}
