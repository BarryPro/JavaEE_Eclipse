package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/7/25.
 */
public class MzoneFreeEntity implements Serializable {
    @JSONField(name = "PROD_PRC_ID")
    @ParamDesc(path = "PROD_PRC_ID", desc = "资费ID", cons = ConsType.CT001, len = "20", memo = "")
    private String prodPrcId;

    @JSONField(name = "PROD_PRC_TYPE")
    @ParamDesc(path = "PROD_PRC_TYPE", desc = "资费类型标识", cons = ConsType.CT001, len = "2", memo = "")
    private String prodPrcType;

    @JSONField(name = "REGION_CODE")
    @ParamDesc(path = "REGION_CODE", desc = "归属地市", cons = ConsType.CT001, len = "4", memo = "")
    private String regionCode;

    @JSONField(name = "TIME_TOTAL")
    @ParamDesc(path = "TIME_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "优惠总时长", memo = "")
    private long timeTotal;

    @JSONField(name = "TIME_USED")
    @ParamDesc(path = "TIME_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用优惠时长", memo = "")
    private long timeUsed;

    @JSONField(name = "TIME_REMAIN")
    @ParamDesc(path = "TIME_REMAIN", cons = ConsType.CT001, len = "8", type = "long", desc = "剩余优惠时长", memo = "")
    private long timeRemain;

    @JSONField(name = "SMS_TOTAL")
    @ParamDesc(path = "SMS_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "短信优惠总条数", memo = "")
    private long smsTotal;

    @JSONField(name = "SMS_USED")
    @ParamDesc(path = "SMS_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用短信优惠条数", memo = "")
    private long smsUsed;

    @JSONField(name = "SMS_REMAIN")
    @ParamDesc(path = "SMS_REMAIN", cons = ConsType.CT001, len = "8", type = "long", desc = "剩余短信", memo = "")
    private long smsRemain;

    public String getProdPrcId() {
        return prodPrcId;
    }

    public void setProdPrcId(String prodPrcId) {
        this.prodPrcId = prodPrcId;
    }

    public String getProdPrcType() {
        return prodPrcType;
    }

    public void setProdPrcType(String prodPrcType) {
        this.prodPrcType = prodPrcType;
    }

    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
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

    public long getSmsTotal() {
        return smsTotal;
    }

    public void setSmsTotal(long smsTotal) {
        this.smsTotal = smsTotal;
    }

    public long getSmsUsed() {
        return smsUsed;
    }

    public void setSmsUsed(long smsUsed) {
        this.smsUsed = smsUsed;
    }

    public long getSmsRemain() {
        return smsRemain;
    }

    public void setSmsRemain(long smsRemain) {
        this.smsRemain = smsRemain;
    }

    @Override
    public String toString() {
        return "MzoneFreeEntity{" +
                "prodPrcId='" + prodPrcId + '\'' +
                ", prodPrcType='" + prodPrcType + '\'' +
                ", regionCode='" + regionCode + '\'' +
                ", timeTotal=" + timeTotal +
                ", timeUsed=" + timeUsed +
                ", timeRemain=" + timeRemain +
                ", smsTotal=" + smsTotal +
                ", smsUsed=" + smsUsed +
                ", smsRemain=" + smsRemain +
                '}';
    }
}
