package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class IncomeBill {

    @JSONField(name = "OP_TIME")
    @ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "string", len = "20", desc = "时间", memo = "")
    private String opTime;

    @JSONField(name = "PAY_FEE")
    @ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, type = "long", len = "", desc = "金额", memo = "")
    private long payFee;

    @JSONField(name = "PAY_NAME")
    @ParamDesc(path = "PAY_NAME", cons = ConsType.CT001, type = "string", len = "20", desc = "类别", memo = "")
    private String payName;

    @JSONField(name = "REMARK")
    @ParamDesc(path = "REMARK", cons = ConsType.CT001, type = "string", len = "128", desc = "备注", memo = "")
    private String remark;

    @JSONField(name = "PAY_TYPE")
    @ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "方式", memo = "")
    private String statusName;

    @JSONField(name = "PAY_ATTR")
    private String attr;

    @JSONField(name = "CONTRACT_NO")
    private long con;

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime;
    }

    public long getPayFee() {
        return payFee;
    }

    public void setPayFee(long payFee) {
        this.payFee = payFee;
    }

    public String getPayName() {
        return payName;
    }

    public void setPayName(String payName) {
        this.payName = payName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public long getCon() {
        return con;
    }

    public void setCon(long con) {
        this.con = con;
    }

    public String getAttr() {
        return attr;
    }

    public void setAttr(String attr) {
        this.attr = attr;
    }

    @Override
    public String toString() {
        return "IncomeBill{" +
                "opTime='" + opTime + '\'' +
                ", payFee=" + payFee +
                ", payName='" + payName + '\'' +
                ", remark='" + remark + '\'' +
                ", statusName='" + statusName + '\'' +
                ", attr='" + attr + '\'' +
                ", con=" + con +
                '}';
    }

}
