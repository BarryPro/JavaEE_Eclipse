package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FamFreeUseInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/2/6.
 */
public class SFamilyFreeShareQueryOutDTO extends CommonOutDTO {
    @JSONField(name = "VOICE_BASE_INFO")
    @ParamDesc(path = "VOICE_BASE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "家庭共享语音基本列表", memo = "list;时长的单位：分钟")
    private List<FamFreeUseInfoEntity> voiceBaseList;

    @JSONField(name = "VOICE_LONG_INFO")
    @ParamDesc(path = "VOICE_LONG_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "家庭共享长途语音列表", memo = "list;时长的单位：分钟")
    private List<FamFreeUseInfoEntity> voiceLongList;

    @JSONField(name = "GPRS_NATION_INFO")
    @ParamDesc(path = "GPRS_NATION_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "家庭共享国内GPRS列表", memo = "list;时长的单位：分钟")
    private List<FamFreeUseInfoEntity> gprsNationList;

    @JSONField(name = "GPRS_PROV_INFO")
    @ParamDesc(path = "GPRS_PROV_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "家庭共享省内GPRS列表", memo = "list;时长的单位：分钟")
    private List<FamFreeUseInfoEntity> gprsProvList;

    @JSONField(name = "VOICE_BASE_TOTAL")
    @ParamDesc(path = "VOICE_BASE_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "基本语音总优惠", memo = "单位：分钟")
    private String voiceBaseTotal;

    @JSONField(name = "VOICE_BASE_USED")
    @ParamDesc(path = "VOICE_BASE_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "基本语音已使用", memo = "单位：分钟")
    private String voiceBaseUsed;
    
    @JSONField(name = "VOICE_BASE_REMAIN")
    @ParamDesc(path = "VOICE_BASE_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "基本语音剩余", memo = "单位：分钟")
    private String voiceBaseRemain;

    @JSONField(name = "VOICE_LONG_TOTAL")
    @ParamDesc(path = "VOICE_LONG_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "长途语音总优惠量", memo = "单位：分钟")
    private String voiceLongTotal;

    @JSONField(name = "VOICE_LONG_USED")
    @ParamDesc(path = "VOICE_LONG_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "长途语音总使用量", memo = "单位：分钟")
    private String voiceLongUsed;
    
    @JSONField(name = "VOICE_LONG_REMAIN")
    @ParamDesc(path = "VOICE_LONG_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "长途语音剩余", memo = "单位：分钟")
    private String voiceLongRemain;

    @JSONField(name = "GPRS_TOTAL")
    @ParamDesc(path = "GPRS_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "共享流量总优惠量（含结转）", memo = "单位：MB")
    private String gprsTotal;

    @JSONField(name = "GPRS_USED")
    @ParamDesc(path = "GPRS_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "共享流量已使用总量（含结转）", memo = "单位：MB")
    private String gprsUsed;
    
    @JSONField(name = "GPRS_REMAIN")
    @ParamDesc(path = "GPRS_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "共享流量剩余（含结转）", memo = "单位：MB")
    private String gprsRemain;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("voiceBaseList"), voiceBaseList);
        result.setRoot(getPathByProperName("voiceLongList"), voiceLongList);
        result.setRoot(getPathByProperName("gprsNationList"), gprsNationList);
        result.setRoot(getPathByProperName("gprsProvList"), gprsProvList);
        result.setRoot(getPathByProperName("voiceBaseTotal"), voiceBaseTotal);
        result.setRoot(getPathByProperName("voiceBaseUsed"), voiceBaseUsed);
        result.setRoot(getPathByProperName("voiceBaseRemain"), voiceBaseRemain);
        result.setRoot(getPathByProperName("voiceLongTotal"), voiceLongTotal);
        result.setRoot(getPathByProperName("voiceLongUsed"), voiceLongUsed);
        result.setRoot(getPathByProperName("voiceLongRemain"), voiceLongRemain);
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);
        result.setRoot(getPathByProperName("gprsRemain"), gprsRemain);
        return result;
    }

    public List<FamFreeUseInfoEntity> getVoiceBaseList() {
        return voiceBaseList;
    }

    public void setVoiceBaseList(List<FamFreeUseInfoEntity> voiceBaseList) {
        this.voiceBaseList = voiceBaseList;
    }

    public List<FamFreeUseInfoEntity> getVoiceLongList() {
        return voiceLongList;
    }

    public void setVoiceLongList(List<FamFreeUseInfoEntity> voiceLongList) {
        this.voiceLongList = voiceLongList;
    }

    public List<FamFreeUseInfoEntity> getGprsNationList() {
        return gprsNationList;
    }

    public void setGprsNationList(List<FamFreeUseInfoEntity> gprsNationList) {
        this.gprsNationList = gprsNationList;
    }

    public List<FamFreeUseInfoEntity> getGprsProvList() {
        return gprsProvList;
    }

    public void setGprsProvList(List<FamFreeUseInfoEntity> gprsProvList) {
        this.gprsProvList = gprsProvList;
    }

    public String getVoiceBaseTotal() {
        return voiceBaseTotal;
    }

    public void setVoiceBaseTotal(String voiceBaseTotal) {
        this.voiceBaseTotal = voiceBaseTotal;
    }

    public String getVoiceBaseUsed() {
        return voiceBaseUsed;
    }

    public void setVoiceBaseUsed(String voiceBaseUsed) {
        this.voiceBaseUsed = voiceBaseUsed;
    }

    public String getVoiceLongTotal() {
        return voiceLongTotal;
    }

    public void setVoiceLongTotal(String voiceLongTotal) {
        this.voiceLongTotal = voiceLongTotal;
    }

    public String getVoiceLongUsed() {
        return voiceLongUsed;
    }

    public void setVoiceLongUsed(String voiceLongUsed) {
        this.voiceLongUsed = voiceLongUsed;
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

	public String getVoiceBaseRemain() {
		return voiceBaseRemain;
	}

	public void setVoiceBaseRemain(String voiceBaseRemain) {
		this.voiceBaseRemain = voiceBaseRemain;
	}

	public String getVoiceLongRemain() {
		return voiceLongRemain;
	}

	public void setVoiceLongRemain(String voiceLongRemain) {
		this.voiceLongRemain = voiceLongRemain;
	}

	public String getGprsRemain() {
		return gprsRemain;
	}

	public void setGprsRemain(String gprsRemain) {
		this.gprsRemain = gprsRemain;
	}
    
}
