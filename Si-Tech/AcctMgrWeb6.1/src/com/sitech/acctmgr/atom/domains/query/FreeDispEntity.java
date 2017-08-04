package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangyla on 2016/7/1.
 * 展示优惠信息实体，带明细信息
 */
public class FreeDispEntity implements Serializable {
    @JSONField(name = "BUSI_CODE")
    @ParamDesc(path = "BUSI_CODE", cons = ConsType.CT001, len = "10", type = "string", desc = "业务类型代码", memo = "")
    private String busiCode;

    @JSONField(name = "BUSI_NAME")
    @ParamDesc(path = "BUSI_NAME", cons = ConsType.CT001, len = "24", type = "string", desc = "业务类型名称", memo = "如：GPRS业务、语音业务等")
    private String busiName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001,len = "8", type = "String", desc = "套餐内总优惠",memo = "")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001,len = "8", type = "String", desc = "套餐内总使用",memo = "")
    private String used;

    @JSONField(name = "OUT_USED")
    @ParamDesc(path = "OUT_USED", cons = ConsType.CT001,len = "8", type = "String", desc = "套餐外总使用",memo = "")
    private String outUsed;

    @JSONField(name = "DETAIL_LIST")
    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.CT001,len = "", type = "complex", desc = "该类优惠明细列表",memo = "")
    private List<FreeMinBill> detailList;

    public String getBusiCode() {
        return busiCode;
    }

    public void setBusiCode(String busiCode) {
        this.busiCode = busiCode;
    }

    public String getBusiName() {
        return busiName;
    }

    public void setBusiName(String busiName) {
        this.busiName = busiName;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public String getOutUsed() {
        return outUsed;
    }

    public void setOutUsed(String outUsed) {
        this.outUsed = outUsed;
    }

    public List<FreeMinBill> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FreeMinBill> detailList) {
        this.detailList = detailList;
    }

    @Override
    public String toString() {
        return "Free2DispEntity{" +
                "busiCode='" + busiCode + '\'' +
                ", busiName='" + busiName + '\'' +
                ", total='" + total + '\'' +
                ", used='" + used + '\'' +
                ", outUsed='" + outUsed + '\'' +
                ", detailList=" + detailList +
                '}';
    }


}
