package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/25.
 */
public class SFamilyFreeQueryOutDTO extends CommonOutDTO {
    @JSONField(name = "VOICE_TOTAL")
    @ParamDesc(path = "VOICE_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "语音优惠总时长", memo = "单位：分钟")
    private long voiceTotal;

    @JSONField(name = "VOICE_USED")
    @ParamDesc(path = "VOICE_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "语音已使用优惠时长", memo = "单位：分钟")
    private long voiceUsed;

    @JSONField(name = "SMS_TOTAL")
    @ParamDesc(path = "SMS_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "短信优惠总条数", memo = "单位：条")
    private long smsTotal;

    @JSONField(name = "SMS_USED")
    @ParamDesc(path = "SMS_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用短信优惠条数", memo = "单位：条")
    private long smsUsed;

    @JSONField(name = "GPRS_TOTAL")
    @ParamDesc(path = "GPRS_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "gprs优惠总量", memo = "单位：KB")
    private long gprsTotal;

    @JSONField(name = "GPRS_USED")
    @ParamDesc(path = "GPRS_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "gprs已优惠量", memo = "单位：KB")
    private long gprsUsed;

    @JSONField(name = "MMS_TOTAL")
    @ParamDesc(path = "MMS_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "彩信优惠总条数", memo = "单位：条")
    private long mmsTotal;

    @JSONField(name = "MMS_USED")
    @ParamDesc(path = "MMS_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用彩信优惠条数", memo = "单位：条")
    private long mmsUsed;

    @JSONField(name = "CMWAP_TOTAL")
    @ParamDesc(path = "CMWAP_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "cmwap优惠总量", memo = "单位：KB")
    private long cmwapTotal;

    @JSONField(name = "CMWAP_USED")
    @ParamDesc(path = "CMWAP_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "cmwap已优惠量", memo = "单位：KB")
    private long cmwapUsed;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("voiceTotal"), voiceTotal);
        result.setRoot(getPathByProperName("voiceUsed"), voiceUsed);
        result.setRoot(getPathByProperName("smsTotal"), smsTotal);
        result.setRoot(getPathByProperName("smsUsed"), smsUsed);
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);
        result.setRoot(getPathByProperName("mmsTotal"), mmsTotal);
        result.setRoot(getPathByProperName("mmsUsed"), mmsUsed);
        result.setRoot(getPathByProperName("cmwapTotal"), cmwapTotal);
        result.setRoot(getPathByProperName("cmwapUsed"), cmwapUsed);
        return result;
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

    public long getGprsTotal() {
        return gprsTotal;
    }

    public void setGprsTotal(long gprsTotal) {
        this.gprsTotal = gprsTotal;
    }

    public long getGprsUsed() {
        return gprsUsed;
    }

    public void setGprsUsed(long gprsUsed) {
        this.gprsUsed = gprsUsed;
    }

    public long getMmsTotal() {
        return mmsTotal;
    }

    public void setMmsTotal(long mmsTotal) {
        this.mmsTotal = mmsTotal;
    }

    public long getMmsUsed() {
        return mmsUsed;
    }

    public void setMmsUsed(long mmsUsed) {
        this.mmsUsed = mmsUsed;
    }

    public long getCmwapTotal() {
        return cmwapTotal;
    }

    public void setCmwapTotal(long cmwapTotal) {
        this.cmwapTotal = cmwapTotal;
    }

    public long getCmwapUsed() {
        return cmwapUsed;
    }

    public void setCmwapUsed(long cmwapUsed) {
        this.cmwapUsed = cmwapUsed;
    }
}
