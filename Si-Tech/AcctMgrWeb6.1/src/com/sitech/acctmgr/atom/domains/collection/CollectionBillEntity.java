package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * <p>Title: 托收账单数据实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class CollectionBillEntity {

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "账户号码", memo = "略")
    private long contractNo;

    @JSONField(name = "BILL_CYCLE")
    @ParamDesc(path = "BILL_CYCLE", cons = ConsType.QUES, type = "String", len = "6", desc = "托收月份", memo = "略")
    private int billCycle;

    @JSONField(name = "PAY_FEE")
    @ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "托收金额", memo = "略")
    private long payFee;

    @JSONField(name = "PAY_NUM")
    @ParamDesc(path = "PAY_NUM", cons = ConsType.CT001, type = "long", len = "10", desc = "托收用户数 ", memo = "略")
    private long payNum;

    @JSONField(name = "DEAL_FLAG")
    @ParamDesc(path = "DEAL_FLAG", cons = ConsType.CT001, type = "string", len = "1", desc = "托收处理状态 ", memo = "0：未处理；1：已处理")
    private String dealFlag;

    @JSONField(name = "GROUP_ID")
    @ParamDesc(path = "GROUP_ID", cons = ConsType.CT001, type = "string", len = "10", desc = "托收帐户的机构代码 ", memo = "略")
    private String groupId;

    @JSONField(name = "RETURN_CODE")
    @ParamDesc(path = "RETURN_CODE", cons = ConsType.CT001, type = "String", len = "4", desc = "托收代码 ", memo = "略")
    private String returnCode;

    @JSONField(name = "BILL_DAY")
    @ParamDesc(path = "BILL_DAY", cons = ConsType.CT001, type = "int", len = "6", desc = "批次 ", memo = "略")
    private int billDay;


    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public int getBillCycle() {
        return billCycle;
    }

    public void setBillCycle(int billCycle) {
        this.billCycle = billCycle;
    }

    public long getPayFee() {
        return payFee;
    }

    public void setPayFee(long payFee) {
        this.payFee = payFee;
    }

    public long getPayNum() {
        return payNum;
    }

    public void setPayNum(long payNum) {
        this.payNum = payNum;
    }

    public String getDealFlag() {
        return dealFlag;
    }

    public void setDealFlag(String dealFlag) {
        this.dealFlag = dealFlag;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public int getBillDay() {
        return billDay;
    }

    public void setBillDay(int billDay) {
        this.billDay = billDay;
    }

    @Override
    public String toString() {
        return "CollectionBillEntity{" +
                "contractNo=" + contractNo +
                ", billCycle=" + billCycle +
                ", payFee=" + payFee +
                ", payNum=" + payNum +
                ", dealFlag='" + dealFlag + '\'' +
                ", groupId='" + groupId + '\'' +
                ", returnCode='" + returnCode + '\'' +
                ", billDay=" + billDay +
                '}';
    }
}
