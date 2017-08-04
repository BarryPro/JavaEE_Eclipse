package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STimeYearFreeQueryOutDTO extends CommonOutDTO{
    @ParamDesc(path = "TOTAL_FEE", desc = "总优惠费用", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long totalFee;

    @ParamDesc(path = "USED_FEE", desc = "已优惠费用", cons = ConsType.CT001, type = "long",len = "14", memo = "")
    private long usedFee;

    @ParamDesc(path = "REMAIN_FEE", desc = "剩余优惠费用", cons = ConsType.CT001, type = "long",len = "14", memo = "")
    private long remainFee;

    @ParamDesc(path = "TIME_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "优惠总时长", memo = "")
    private long timeTotal;

    @ParamDesc(path = "TIME_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用优惠时长", memo = "")
    private long timeUsed;

    @ParamDesc(path = "TIME_REMAIN", cons = ConsType.CT001, len = "8", type = "long", desc = "剩余优惠时长", memo = "")
    private long timeRemain;

    @ParamDesc(path = "EXP_DATE", cons = ConsType.CT001, len = "8", type = "string", desc = "失效时间", memo = "格式：YYYYMMDD")
    private String expDate;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("totalFee"), totalFee);
        result.setRoot(getPathByProperName("usedFee"), usedFee);
        result.setRoot(getPathByProperName("remainFee"), remainFee);
        result.setRoot(getPathByProperName("timeTotal"), timeTotal);
        result.setRoot(getPathByProperName("timeUsed"), timeUsed);
        result.setRoot(getPathByProperName("timeRemain"), timeRemain);
        result.setRoot(getPathByProperName("expDate"), expDate);
        return result;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

    public long getUsedFee() {
        return usedFee;
    }

    public void setUsedFee(long usedFee) {
        this.usedFee = usedFee;
    }

    public long getRemainFee() {
        return remainFee;
    }

    public void setRemainFee(long remainFee) {
        this.remainFee = remainFee;
    }

    public long getTimeTotal() {
        return timeTotal;
    }

    public void setTimeTotal(long timeTotal) {
        this.timeTotal = timeTotal;
    }

    public long getTimeUsed() {
        return timeUsed;
    }

    public void setTimeUsed(long timeUsed) {
        this.timeUsed = timeUsed;
    }

    public long getTimeRemain() {
        return timeRemain;
    }

    public void setTimeRemain(long timeRemain) {
        this.timeRemain = timeRemain;
    }

    public String getExpDate() {
        return expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }
}
