package com.sitech.acctmgr.atom.domains.detail;

/**
 * 功能：地市详单查询次数限制的数据实体
 * act_detaillimit_conf
 * Created by wangyla on 2016/10/21.
 */
public class DetailLimitEntity {
    private String loginNo;
    private String opCode;
    private String powerType;
    private String opTime;
    private String lastTime;
    private int maxQuerySum;
    private int usedSum;

    public String getLoginNo() {
        return loginNo;
    }

    public void setLoginNo(String loginNo) {
        this.loginNo = loginNo;
    }

    public String getOpCode() {
        return opCode;
    }

    public void setOpCode(String opCode) {
        this.opCode = opCode;
    }

    public String getPowerType() {
        return powerType;
    }

    public void setPowerType(String powerType) {
        this.powerType = powerType;
    }

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime;
    }

    public String getLastTime() {
        return lastTime;
    }

    public void setLastTime(String lastTime) {
        this.lastTime = lastTime;
    }

    public int getMaxQuerySum() {
        return maxQuerySum;
    }

    public void setMaxQuerySum(int maxQuerySum) {
        this.maxQuerySum = maxQuerySum;
    }

    public int getUsedSum() {
        return usedSum;
    }

    public void setUsedSum(int usedSum) {
        this.usedSum = usedSum;
    }

    @Override
    public String toString() {
        return "DetailLimitEntity{" +
                "loginNo='" + loginNo + '\'' +
                ", opCode='" + opCode + '\'' +
                ", powerType='" + powerType + '\'' +
                ", opTime='" + opTime + '\'' +
                ", lastTime='" + lastTime + '\'' +
                ", maxQuerySum=" + maxQuerySum +
                ", usedSum=" + usedSum +
                '}';
    }
}
