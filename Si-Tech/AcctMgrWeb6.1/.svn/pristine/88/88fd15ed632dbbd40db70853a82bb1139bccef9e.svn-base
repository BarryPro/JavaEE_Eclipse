package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * @Description: 帐户托收单信息
 * @author: wangyla
 * @version:
 * @createTime: 2015-3-16 下午7:59:43
 */

public class CollBillInfoEntity implements Serializable {
    private static final long serialVersionUID = 5419589385141372461L;

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "托收帐户号码", type = "long", memo = "略")
    private long contractNo = 0;
    @JSONField(name = "BILL_CYCLE")
    @ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, len = "6", desc = "托收帐期", type = "int", memo = "略")
    private int billCycle;
    @JSONField(name = "PAY_FEE")
    @ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, len = "14", desc = "托收金额", type = "long", memo = "略")
    private long payFee;
    @JSONField(name = "PAY_NUM")
    @ParamDesc(path = "PAY_NUM", cons = ConsType.CT001, len = "4", desc = "托收用户数", type = "int", memo = "略")
    private long payNum;
    @JSONField(name = "DEAL_FLAG")
    @ParamDesc(path = "DEAL_FLAG", cons = ConsType.CT001, len = "1", desc = "处理标识", type = "string", memo = "略")
    private String dealFlag;
    @JSONField(name = "DEAL_NAME")
    @ParamDesc(path = "DEAL_NAME", cons = ConsType.CT001, len = "20", desc = "处理状态名称", type = "string", memo = "略")
    private String dealName;
    @JSONField(name = "BANK_CODE")
    @ParamDesc(path = "BANK_CODE", cons = ConsType.CT001, len = "12", desc = "银行代码", type = "string", memo = "略")
    private String bankCode;
    @JSONField(name = "BANK_NAME")
    @ParamDesc(path = "BANK_NAME", cons = ConsType.CT001, len = "60", desc = "银行名称", type = "string", memo = "略")
    private String bankName;
    @JSONField(name = "REGION_NAME")
    @ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, len = "100", desc = "地市名称", type = "string", memo = "略")
    private String regionName;
    @JSONField(name = "CONTRACT_NAME")
    @ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, len = "100", desc = "帐户名称", type = "string", memo = "略")
    private String contractName;
    @JSONField(name = "ACCOUNT_NO")
    @ParamDesc(path = "ACCOUNT_NO", cons = ConsType.CT001, len = "100", desc = "银行账号", type = "string", memo = "略")
    private String accountNo;
    @JSONField(name = "RETURN_CODE")
    @ParamDesc(path = "RETURN_CODE", cons = ConsType.CT001, len = "4", desc = "托收返回代码", type = "string", memo = "略")
    private String returnCode;
    @JSONField(name = "CODE_VALUE")
    @ParamDesc(path = "CODE_VALUE", cons = ConsType.CT001, len = "4", desc = "返回代码名称", type = "string", memo = "略")
    private String codeValue;
    @JSONField(name = "COLL_GROUP_ID")
    @ParamDesc(path = "COLL_GROUP_ID", cons = ConsType.CT001, len = "20", desc = "托收帐户归属", type = "string", memo = "略")
    private String collGroupId;

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

    public String getDealName() {
        return dealName;
    }

    public void setDealName(String dealName) {
        this.dealName = dealName;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getCodeValue() {
        return codeValue;
    }

    public void setCodeValue(String codeValue) {
        this.codeValue = codeValue;
    }

    public String getCollGroupId() {
        return collGroupId;
    }

    public void setCollGroupId(String collGroupId) {
        this.collGroupId = collGroupId;
    }

    @Override
    public String toString() {
        return "CollBillInfoEntity{" +
                "contractNo=" + contractNo +
                ", billCycle=" + billCycle +
                ", payFee=" + payFee +
                ", payNum=" + payNum +
                ", dealFlag='" + dealFlag + '\'' +
                ", dealName='" + dealName + '\'' +
                ", bankCode='" + bankCode + '\'' +
                ", bankName='" + bankName + '\'' +
                ", regionName='" + regionName + '\'' +
                ", contractName='" + contractName + '\'' +
                ", accountNo='" + accountNo + '\'' +
                ", returnCode='" + returnCode + '\'' +
                ", codeValue='" + codeValue + '\'' +
                ", collGroupId='" + collGroupId + '\'' +
                '}';
    }
}
