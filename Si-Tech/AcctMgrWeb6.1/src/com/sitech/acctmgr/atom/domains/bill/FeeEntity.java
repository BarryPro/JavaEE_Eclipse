package com.sitech.acctmgr.atom.domains.bill;

/**
 * Created by wangyla on 2016/10/26.
 * 帐单展示帐户帐本信息时，数据实体
 */
public class FeeEntity {
    private long money;
    private long otherMoney;
    private String type;
    private String typeName; //专款展示使用
    private String specialFlag;
    private String presentFlag;

    public long getMoney() {
        return money;
    }

    public void setMoney(long money) {
        this.money = money;
    }

    public long getOtherMoney() {
        return otherMoney;
    }

    public void setOtherMoney(long otherMoney) {
        this.otherMoney = otherMoney;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getSpecialFlag() {
        return specialFlag;
    }

    public void setSpecialFlag(String specialFlag) {
        this.specialFlag = specialFlag;
    }

    public String getPresentFlag() {
        return presentFlag;
    }

    public void setPresentFlag(String presentFlag) {
        this.presentFlag = presentFlag;
    }

    @Override
    public String toString() {
        return "FeeEntity{" +
                "money=" + money +
                ", otherMoney=" + otherMoney +
                ", type='" + type + '\'' +
                ", typeName='" + typeName + '\'' +
                ", specialFlag='" + specialFlag + '\'' +
                ", presentFlag='" + presentFlag + '\'' +
                '}';
    }
}
