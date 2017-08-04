package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：托收银行信息
 */
@SuppressWarnings("serial")
public class PayeeBankEntity implements Serializable {
    @JSONField(name = "REGION_CODE")
    @ParamDesc(path = "REGION_CODE", cons = ConsType.CT001, len = "10", desc = "归属代码", type = "string", memo = "区县代码或地市机构")
    private String regionCode;
    @JSONField(name = "REGION_NAME")
    @ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, len = "40", desc = "归属名称", type = "string", memo = "略")
    private String regionName;
    @JSONField(name = "CUST_BANK_1")
    @ParamDesc(path = "CUST_BANK_1", cons = ConsType.CT001, len = "20", desc = "收款方名称1", type = "string", memo = "中国移动通信集团")
    private String custBank1;
    @JSONField(name = "CUST_BANK_2")
    @ParamDesc(path = "CUST_BANK_2", cons = ConsType.CT001, len = "40", desc = "收款方名称2", type = "string", memo = "吉林有限公司长春城区分公司  等")
    private String custBank2;
    @JSONField(name = "ACCOUNT_NO")
    @ParamDesc(path = "ACCOUNT_NO", cons = ConsType.CT001, len = "30", desc = "收款方银行帐户", type = "string", memo = "略")
    private String accountNo;
    @JSONField(name = "BANK_NAME")
    @ParamDesc(path = "BANK_NAME", cons = ConsType.CT001, len = "60", desc = "收款方银行名称", type = "string", memo = "略")
    private String bankName;

    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public String getCustBank1() {
        return custBank1;
    }

    public void setCustBank1(String custBank1) {
        this.custBank1 = custBank1;
    }

    public String getCustBank2() {
        return custBank2;
    }

    public void setCustBank2(String custBank2) {
        this.custBank2 = custBank2;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    @Override
    public String toString() {
        return "PayeeBankEntity{" +
                "regionCode='" + regionCode + '\'' +
                ", regionName='" + regionName + '\'' +
                ", custBank1='" + custBank1 + '\'' +
                ", custBank2='" + custBank2 + '\'' +
                ", accountNo='" + accountNo + '\'' +
                ", bankName='" + bankName + '\'' +
                '}';
    }

}
