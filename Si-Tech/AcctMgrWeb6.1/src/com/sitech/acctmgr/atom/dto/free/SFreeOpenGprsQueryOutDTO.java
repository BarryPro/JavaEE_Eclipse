package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeGprsDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/6/6.
 */
public class SFreeOpenGprsQueryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "BizCode", cons = ConsType.QUES, type = "String", len = "4", desc = "返回码", memo = "略")
    private String retCode;
    @ParamDesc(path = "BizDesc", cons = ConsType.QUES, type = "String", len = "256", desc = "错误信息描述", memo = "略")
    private String retMsg;
    @ParamDesc(path = "ServiceNumber", cons = ConsType.CT001, type = "String", len = "14", desc = "服务号码", memo = "")
    private String phoneNo;

    @JSONField(name = "BillValue")
    @ParamDesc(path = "BillValue", cons = ConsType.CT001, len = "20", desc = "流量总量", type = "String", memo = "")
    private String gprsTotal;

    @JSONField(name = "UsedValue")
    @ParamDesc(path = "UsedValue", cons = ConsType.CT001, len = "20", desc = "已使用总量", type = "String", memo = "")
    private String gprsUsed;

    @ParamDesc(path = "PackageUsedList", cons = ConsType.PLUS, type = "complex", len = "", desc = "套餐使用明细", memo = "列表")
    private List<FreeGprsDetailEntity> detailList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("retCode"), retCode);
        result.setRoot(getPathByProperName("retMsg"), retMsg);
        result.setRoot(getPathByProperName("phoneNo"), phoneNo);
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);
        result.setRoot(getPathByProperName("detailList"), detailList);

        return result;
    }

    public String getRetCode() {
        return retCode;
    }

    public void setRetCode(String retCode) {
        this.retCode = retCode;
    }

    public String getRetMsg() {
        return retMsg;
    }

    public void setRetMsg(String retMsg) {
        this.retMsg = retMsg;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getGprsTotal() {
        return gprsTotal;
    }

    public void setGprsTotal(String gprsTotal) {
        this.gprsTotal = gprsTotal;
    }

    public String getGprsUsed() {
        return gprsUsed;
    }

    public void setGprsUsed(String gprsUsed) {
        this.gprsUsed = gprsUsed;
    }

    public List<FreeGprsDetailEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<FreeGprsDetailEntity> detailList) {
        this.detailList = detailList;
    }
}
