package com.sitech.acctmgr.atom.domains.free;

/**
 * REMIND_MONTH_FREE_FEE_USER 表实体
 * Created by wangyla on 2016/8/18.
 */
public class FamilyFreeFeeUserEntity {
    private long freeFee; //优惠费用，单位分
    private long voiceUsed;
    private String pkRate;
    private String groupType; //亲情网群组类型标识
    private String groupName; //亲情网群组名称
    private String ctrlFlag; //控制标识 N：成员；O：家长
    private String level;

    public long getFreeFee() {
        return freeFee;
    }

    public void setFreeFee(long freeFee) {
        this.freeFee = freeFee;
    }

    public long getVoiceUsed() {
        return voiceUsed;
    }

    public void setVoiceUsed(long voiceUsed) {
        this.voiceUsed = voiceUsed;
    }

    public String getPkRate() {
        return pkRate;
    }

    public void setPkRate(String pkRate) {
        this.pkRate = pkRate;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getCtrlFlag() {
        return ctrlFlag;
    }

    public void setCtrlFlag(String ctrlFlag) {
        this.ctrlFlag = ctrlFlag;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "FamilyFreeFeeUserEntity{" +
                "freeFee=" + freeFee +
                ", voiceUsed='" + voiceUsed + '\'' +
                ", pkRate='" + pkRate + '\'' +
                ", groupType='" + groupType + '\'' +
                ", groupName='" + groupName + '\'' +
                ", ctrlFlag='" + ctrlFlag + '\'' +
                ", level='" + level + '\'' +
                '}';
    }
}
