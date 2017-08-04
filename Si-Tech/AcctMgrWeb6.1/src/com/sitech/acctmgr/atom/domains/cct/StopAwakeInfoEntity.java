package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;

public class StopAwakeInfoEntity implements Serializable {

    @JSONField(name = "OP_TYPE")
    private String opType;

    @JSONField(name = "REGION_CODE")
    private Integer regionCode;

    @JSONField(name = "CARD_TYPE")
    private String cardType;

    @JSONField(name = "CREDIT_CODE")
    private String creditCode;

    @JSONField(name = "CREDIT_NAME")
    private String creditName;

    @JSONField(name = "SPECIAL_LIST")
    private String specialList;

    @JSONField(name = "OVER_FEE")
    private Long overFee;

    @JSONField(name = "AWAKE_FEE")
    private Long awakeFee;

    @JSONField(name = "OWE_AWAKE_FEE")
    private Long oweAwakeFee;

    @JSONField(name = "SINGLESTOP_DAYS")
    private Integer singlestopDays;

    @JSONField(name = "VOICESTOP_DAYS")
    private Integer voicestopDays;

    @JSONField(name = "LIMIT_DAYS")
    private Integer limitDays;

    @JSONField(name = "CALLING_TIMES")
    private Integer callingTimes;

    @JSONField(name = "AWAKE_TIMES")
    private Integer awakeTimes;

    @JSONField(name = "OWE_AWAKE_TIMES")
    private Integer oweAwakeTimes;

    @JSONField(name = "CREDIT_TYPE")
    private String creditType;

    @JSONField(name = "CREDIT_AWAKE_FLAG")
    private Integer creditAwakeFlag;


    public String getOpType() {
        return this.opType;
    }

    public void setOpType(String opType) {
        this.opType = opType;
    }

    public Integer getRegionCode() {
        return this.regionCode;
    }

    public void setRegionCode(Integer regionCode) {
        this.regionCode = regionCode;
    }

    public String getCardType() {
        return this.cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public String getCreditCode() {
        return this.creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode;
    }

    public String getCreditName() {
        return this.creditName;
    }

    public void setCreditName(String creditName) {
        this.creditName = creditName;
    }

    public String getSpecialList() {
        return this.specialList;
    }

    public void setSpecialList(String specialList) {
        this.specialList = specialList;
    }

    public Long getOverFee() {
        return this.overFee;
    }

    public void setOverFee(Long overFee) {
        this.overFee = overFee;
    }

    public Long getAwakeFee() {
        return this.awakeFee;
    }

    public void setAwakeFee(Long awakeFee) {
        this.awakeFee = awakeFee;
    }

    public Long getOweAwakeFee() {
        return this.oweAwakeFee;
    }

    public void setOweAwakeFee(Long oweAwakeFee) {
        this.oweAwakeFee = oweAwakeFee;
    }

    public Integer getSinglestopDays() {
        return this.singlestopDays;
    }

    public void setSinglestopDays(Integer singlestopDays) {
        this.singlestopDays = singlestopDays;
    }

    public Integer getVoicestopDays() {
        return this.voicestopDays;
    }

    public void setVoicestopDays(Integer voicestopDays) {
        this.voicestopDays = voicestopDays;
    }

    public Integer getLimitDays() {
        return this.limitDays;
    }

    public void setLimitDays(Integer limitDays) {
        this.limitDays = limitDays;
    }

    public Integer getCallingTimes() {
        return this.callingTimes;
    }

    public void setCallingTimes(Integer callingTimes) {
        this.callingTimes = callingTimes;
    }

    public Integer getAwakeTimes() {
        return this.awakeTimes;
    }

    public void setAwakeTimes(Integer awakeTimes) {
        this.awakeTimes = awakeTimes;
    }

    public Integer getOweAwakeTimes() {
        return this.oweAwakeTimes;
    }

    public void setOweAwakeTimes(Integer oweAwakeTimes) {
        this.oweAwakeTimes = oweAwakeTimes;
    }

    public String getCreditType() {
        return this.creditType;
    }

    public void setCreditType(String creditType) {
        this.creditType = creditType;
    }

    public Integer getCreditAwakeFlag() {
        return this.creditAwakeFlag;
    }

    public void setCreditAwakeFlag(Integer creditAwakeFlag) {
        this.creditAwakeFlag = creditAwakeFlag;
    }

    @Override
    public String toString() {
        return "StopAwakeInfoEntity{" +
                "opType='" + opType + '\'' +
                ", regionCode=" + regionCode +
                ", cardType='" + cardType + '\'' +
                ", creditCode='" + creditCode + '\'' +
                ", creditName='" + creditName + '\'' +
                ", specialList='" + specialList + '\'' +
                ", overFee=" + overFee +
                ", awakeFee=" + awakeFee +
                ", oweAwakeFee=" + oweAwakeFee +
                ", singlestopDays=" + singlestopDays +
                ", voicestopDays=" + voicestopDays +
                ", limitDays=" + limitDays +
                ", callingTimes=" + callingTimes +
                ", awakeTimes=" + awakeTimes +
                ", oweAwakeTimes=" + oweAwakeTimes +
                ", creditType='" + creditType + '\'' +
                ", creditAwakeFlag=" + creditAwakeFlag +
                '}';
    }
}