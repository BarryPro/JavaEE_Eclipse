package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/1/20.
 */
public class SDxFreeQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "REAL_FEE")
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "实收", memo = "单位：分")
    private long realFee;

    @JSONField(name = "DX_TOTAL")
    @ParamDesc(path = "DX_TOTAL", cons = ConsType.CT001, type = "long", len = "14", desc = "底线总优惠金额", memo = "单位：分")
    private long dxTotal;

    @JSONField(name = "DX_USED")
    @ParamDesc(path = "DX_USED", cons = ConsType.CT001, type = "long", len = "14", desc = "底线已使用优惠金额", memo = "单位：分")
    private long dxUsed;

    @JSONField(name = "DX_REMAIN")
    @ParamDesc(path = "DX_REMAIN", cons = ConsType.CT001, type = "long", len = "14", desc = "底线剩余优惠金额", memo = "单位：分")
    private long dxRemain;

    @JSONField(name = "SHOULD_FEE")
    @ParamDesc(path = "SHOULD_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "应收", memo = "单位：分")
    private long shouldFee;

    @JSONField(name = "VOICE_TOTAL")
    @ParamDesc(path = "VOICE_TOTAL", cons = ConsType.CT001, type = "long", len = "14", desc = "语音优惠总量", memo = "单位：分钟")
    private long voiceTotal;

    @JSONField(name = "VOICE_USED")
    @ParamDesc(path = "VOICE_USED", cons = ConsType.CT001, type = "long", len = "14", desc = "语音优惠已使用量", memo = "单位：分钟")
    private long voiceUsed;

    @JSONField(name = "VOICE_REMAIN")
    @ParamDesc(path = "VOICE_REMAIN", cons = ConsType.CT001, type = "long", len = "14", desc = "语音优惠剩余量", memo = "单位：分钟")
    private long voiceRemain;

    @JSONField(name = "SMS_TOTAL")
    @ParamDesc(path = "SMS_TOTAL", cons = ConsType.CT001, type = "long", len = "14", desc = "短信优惠总条数", memo = "单位：分钟")
    private long smsTotal;

    @JSONField(name = "SMS_USED")
    @ParamDesc(path = "SMS_USED", cons = ConsType.CT001, type = "long", len = "14", desc = "短信优惠已使用量", memo = "单位：分钟")
    private long smsUsed;

    @JSONField(name = "SMS_REMAIN")
    @ParamDesc(path = "SMS_REMAIN", cons = ConsType.CT001, type = "long", len = "14", desc = "短信优惠剩余量", memo = "单位：分钟")
    private long smsRemain;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("realFee"), realFee);
        result.setRoot(getPathByProperName("dxTotal"), dxTotal);
        result.setRoot(getPathByProperName("dxUsed"), dxUsed);
        result.setRoot(getPathByProperName("dxRemain"), dxRemain);
        result.setRoot(getPathByProperName("shouldFee"), shouldFee);
        result.setRoot(getPathByProperName("voiceTotal"), voiceTotal);
        result.setRoot(getPathByProperName("voiceUsed"), voiceUsed);
        result.setRoot(getPathByProperName("voiceRemain"), voiceRemain);
        result.setRoot(getPathByProperName("smsTotal"), smsTotal);
        result.setRoot(getPathByProperName("smsUsed"), smsUsed);
        result.setRoot(getPathByProperName("smsRemain"), smsRemain);
        return result;
    }

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public long getDxTotal() {
        return dxTotal;
    }

    public void setDxTotal(long dxTotal) {
        this.dxTotal = dxTotal;
    }

    public long getDxUsed() {
        return dxUsed;
    }

    public void setDxUsed(long dxUsed) {
        this.dxUsed = dxUsed;
    }

    public long getDxRemain() {
        return dxRemain;
    }

    public void setDxRemain(long dxRemain) {
        this.dxRemain = dxRemain;
    }

    public long getShouldFee() {
        return shouldFee;
    }

    public void setShouldFee(long shouldFee) {
        this.shouldFee = shouldFee;
    }

    public long getVoiceTotal() {
        return voiceTotal;
    }

    public void setVoiceTotal(long voiceTotal) {
        this.voiceTotal = voiceTotal;
    }

    public long getVoiceUsed() {
        return voiceUsed;
    }

    public void setVoiceUsed(long voiceUsed) {
        this.voiceUsed = voiceUsed;
    }

    public long getVoiceRemain() {
        return voiceRemain;
    }

    public void setVoiceRemain(long voiceRemain) {
        this.voiceRemain = voiceRemain;
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
}
