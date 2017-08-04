package com.sitech.acctmgr.atom.domains.account;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * Created by wangyla on 2016/12/8.
 * 托收帐户实体
 */
public class ConTrustEntity {
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号码", memo = "略")
    private long contractNo;

    @JSONField(name="BANK_CODE")
    @ParamDesc(path="BANK_CODE",cons= ConsType.CT001,type="String",len="12",desc="托收银行代码",memo="略")
    private String bankCode;

    @JSONField(name="BANK_CODE")
    @ParamDesc(path="BANK_CODE",cons= ConsType.CT001,type="String",len="12",desc="托收银行代码",memo="略")
    private String postBankCode;

    @JSONField(name="BANK_NAME")
    @ParamDesc(path="BANK_NAME",cons=ConsType.CT001,type="string",len="60",desc="托收银行名称",memo="略")
    private String bankName;

    @JSONField(name="ACCOUNT_NO")
    @ParamDesc(path="ACCOUNT_NO",cons=ConsType.CT001,type="String",len="100",desc="托收银行帐号 ",memo="略")
    private String accountNo;

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getPostBankCode() {
        return postBankCode;
    }

    public void setPostBankCode(String postBankCode) {
        this.postBankCode = postBankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    @Override
    public String toString() {
        return "ConTrustEntity{" +
                "contractNo=" + contractNo +
                ", bankCode='" + bankCode + '\'' +
                ", postBankCode='" + postBankCode + '\'' +
                ", bankName='" + bankName + '\'' +
                ", accountNo='" + accountNo + '\'' +
                '}';
    }
}
