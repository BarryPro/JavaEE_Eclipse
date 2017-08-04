package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/18.
 */
public class SFreeUserFreeQueryOutDTO extends CommonOutDTO{

    @JSONField(name = "VOICE_TOTAL")
    @ParamDesc(path = "VOICE_TOTAL", desc = "语音总优惠量", cons = ConsType.CT001, len = "8", memo = "单位：分钟")
    private long voiceTotal;

    @JSONField(name = "VOICE_USED")
    @ParamDesc(path = "VOICE_USED", desc = "语音已使用量", cons = ConsType.CT001, len = "8", memo = "单位：分钟")
    private long voiceUsed;

    @JSONField(name = "SMS_TOTAL")
    @ParamDesc(path = "SMS_TOTAL", desc = "短信总优惠量", cons = ConsType.CT001, len = "8", memo = "单位：条")
    private long smsTotal;

    @JSONField(name = "SMS_USED")
    @ParamDesc(path = "SMS_USED", desc = "短信已使用量", cons = ConsType.CT001, len = "8", memo = "单位：条")
    private long smsUsed;

    @JSONField(name = "GPRS_TOTAL")
    @ParamDesc(path = "GPRS_TOTAL", desc = "GPRS流量总量", cons = ConsType.CT001, len = "8", memo = "套餐内流量 + 附加流量资费流量;单位KB")
    private long gprsTotal;

    @JSONField(name = "GPRS_USED")
    @ParamDesc(path = "GPRS_USED", desc = "GPRS流量优惠总使用量", cons = ConsType.CT001, len = "8", memo = "套餐内流量 + 附加流量资费流量；单位KB")
    private long gprsUsed;

    @JSONField(name = "CMWAP_TOTAL")
    @ParamDesc(path = "CMWAP_TOTAL", desc = "CMWAP流量总量", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long cmwapTotal;

    @JSONField(name = "CMWAP_USED")
    @ParamDesc(path = "CMWAP_USED", desc = "CMWAP流量优惠总量", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long cmwapUsed;

    @JSONField(name = "MMS_TOTAL")
    @ParamDesc(path = "MMS_TOTAL", desc = "彩信总优惠量", cons = ConsType.CT001, len = "8", memo = "单位：条")
    private long mmsTotal;

    @JSONField(name = "MMS_USED")
    @ParamDesc(path = "MMS_USED", desc = "彩信已使用量", cons = ConsType.CT001, len = "8", memo = "单位：条")
    private long mmsUsed;

    @JSONField(name = "MEAL_GPRS_TOTAL")
    @ParamDesc(path = "MEAL_GPRS_TOTAL", desc = "GPRS主套餐流量总量", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long mealGprsTotal;

    @JSONField(name = "MEAL_GPRS_USED")
    @ParamDesc(path = "MEAL_GPRS_USED", desc = "GPRS主套餐流量优惠", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long mealGprsUsed;

    @JSONField(name = "ADDED_GPRS_TOTAL")
    @ParamDesc(path = "ADDED_GPRS_TOTAL", desc = "附加流量资费优惠总量", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long addedGprsTotal;

    @JSONField(name = "ADDED_GPRS_USED")
    @ParamDesc(path = "ADDED_GPRS_USED", desc = "附加资费资费优惠总使用量", cons = ConsType.CT001, len = "8", memo = "单位：KB")
    private long addedGprsUsed;

    @JSONField(name = "VPMN_TOTAL")
    @ParamDesc(path = "VPMN_TOTAL", desc = "VPMN优惠总量", cons = ConsType.CT001, len = "8", memo = "单位：分钟")
    private long vpmnTotal;

    @JSONField(name = "VPMN_USED")
    @ParamDesc(path = "VPMN_USED", desc = "VPMN已使用量", cons = ConsType.CT001, len = "8", memo = "单位：分钟")
    private long vpmnUsed;

    @JSONField(name = "VPMN_REMAIN")
    @ParamDesc(path = "VPMN_REMAIN", desc = "VPMN剩余量", cons = ConsType.CT001, len = "8", memo = "单位：分钟")
    private long vpmnRemain;

    @JSONField(name = "BRAND_NAME")
    @ParamDesc(path = "BRAND_NAME", desc = "用户品牌名称", cons = ConsType.CT001, len = "20", memo = "")
    private String brandName;

    @JSONField(name = "FREE_INFO")
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "优惠信息明细", memo = "list；子节点流量单位KB")
    private List<FreeDetailEntity> freeList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("voiceTotal"), voiceTotal);
        result.setRoot(getPathByProperName("voiceUsed"), voiceUsed);
        result.setRoot(getPathByProperName("smsTotal"), smsTotal);
        result.setRoot(getPathByProperName("smsUsed"), smsUsed);
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);
        result.setRoot(getPathByProperName("cmwapTotal"), cmwapTotal);
        result.setRoot(getPathByProperName("cmwapUsed"), cmwapUsed);
        result.setRoot(getPathByProperName("mmsTotal"), mmsTotal);
        result.setRoot(getPathByProperName("mmsUsed"), mmsUsed);
        result.setRoot(getPathByProperName("mealGprsTotal"), mealGprsTotal);
        result.setRoot(getPathByProperName("mealGprsUsed"), mealGprsUsed);
        result.setRoot(getPathByProperName("addedGprsTotal"), addedGprsTotal);
        result.setRoot(getPathByProperName("addedGprsUsed"), addedGprsUsed);
        result.setRoot(getPathByProperName("vpmnTotal"), vpmnTotal);
        result.setRoot(getPathByProperName("vpmnUsed"), vpmnUsed);
        result.setRoot(getPathByProperName("vpmnRemain"), vpmnRemain);
        result.setRoot(getPathByProperName("brandName"), brandName);
        result.setRoot(getPathByProperName("freeList"), freeList);
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

    public long getMealGprsTotal() {
        return mealGprsTotal;
    }

    public void setMealGprsTotal(long mealGprsTotal) {
        this.mealGprsTotal = mealGprsTotal;
    }

    public long getMealGprsUsed() {
        return mealGprsUsed;
    }

    public void setMealGprsUsed(long mealGprsUsed) {
        this.mealGprsUsed = mealGprsUsed;
    }

    public long getAddedGprsTotal() {
        return addedGprsTotal;
    }

    public void setAddedGprsTotal(long addedGprsTotal) {
        this.addedGprsTotal = addedGprsTotal;
    }

    public long getAddedGprsUsed() {
        return addedGprsUsed;
    }

    public void setAddedGprsUsed(long addedGprsUsed) {
        this.addedGprsUsed = addedGprsUsed;
    }

    public long getVpmnTotal() {
        return vpmnTotal;
    }

    public void setVpmnTotal(long vpmnTotal) {
        this.vpmnTotal = vpmnTotal;
    }

    public long getVpmnUsed() {
        return vpmnUsed;
    }

    public void setVpmnUsed(long vpmnUsed) {
        this.vpmnUsed = vpmnUsed;
    }

    public long getVpmnRemain() {
        return vpmnRemain;
    }

    public void setVpmnRemain(long vpmnRemain) {
        this.vpmnRemain = vpmnRemain;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public List<FreeDetailEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<FreeDetailEntity> freeList) {
        this.freeList = freeList;
    }

    @Override
    public String toString() {
        return "SFreeUserFreeQueryOutDTO{" +
                "voiceTotal=" + voiceTotal +
                ", voiceUsed=" + voiceUsed +
                ", smsTotal=" + smsTotal +
                ", smsUsed=" + smsUsed +
                ", gprsTotal=" + gprsTotal +
                ", gprsUsed=" + gprsUsed +
                ", cmwapTotal=" + cmwapTotal +
                ", cmwapUsed=" + cmwapUsed +
                ", mmsTotal=" + mmsTotal +
                ", mmsUsed=" + mmsUsed +
                ", mealGprsTotal=" + mealGprsTotal +
                ", mealGprsUsed=" + mealGprsUsed +
                ", addedGprsTotal=" + addedGprsTotal +
                ", addedGprsUsed=" + addedGprsUsed +
                ", vpmnTotal=" + vpmnTotal +
                ", vpmnUsed=" + vpmnUsed +
                ", vpmnRemain=" + vpmnRemain +
                ", brandName='" + brandName + '\'' +
                ", freeList=" + freeList +
                '}';
    }
}
