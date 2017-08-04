package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2017/6/7.
 */
public class FreeDetailLv1InEntity implements Serializable {

    @JSONField(name = "ResourcesCode")
    @ParamDesc(path = "ResourcesCode", cons = ConsType.CT001, type = "string", len = "2", desc = "资源类型代码", memo = "01:语音；02：短信；03：彩信；04：GPRS；05：WLAN；")
    private String resCode;

    @JSONField(name = "IsMultiTerm")
    @ParamDesc(path = "IsMultiTerm", cons = ConsType.QUES, type = "string", len = "1", desc = "流量是否多终端共享", memo = "0-已共享;1-未共享;只需要主号码返回此字段;资源分类为04并且为4G套餐时必须返回，3G套餐或资源分类为其他值时不返回")
    private String shareFlag;

    @JSONField(name = "SecResourcesInfo")
    @ParamDesc(path = "SecResourcesInfo", cons = ConsType.PLUS, type = "complex", len = "", desc = "二级资源信息", memo = "列表")
    private List<FreeDetailLv2InEntity> detailList;

    public String getResCode() {
        return resCode;
    }

    public void setResCode(String resCode) {
        this.resCode = resCode;
    }

    public String getShareFlag() {
        return shareFlag;
    }

    public void setShareFlag(String shareFlag) {
        this.shareFlag = shareFlag;
    }

    public List<FreeDetailLv2InEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FreeDetailLv2InEntity> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "FreeDetailLv1InEntity{" +
                "resCode='" + resCode + '\'' +
                ", shareFlag='" + shareFlag + '\'' +
                ", detailList=" + detailList +
                '}';
    }
}
