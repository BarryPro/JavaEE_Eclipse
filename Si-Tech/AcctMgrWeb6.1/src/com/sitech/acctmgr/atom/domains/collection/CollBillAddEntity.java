package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * Created by wangyla on 2017/1/14.
 */
public class CollBillAddEntity {
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "托收帐户号码", type = "long", memo = "略")
    private long contractNo;

    @JSONField(name = "PAY_FEE")
    @ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, len = "", desc = "托收金额", type = "long", memo = "略")
    private long payFee;

    @JSONField(name = "BILL_CYCLE")
    @ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, len = "6", desc = "托收帐期", type = "int", memo = "略")
    private int billCycle;

    @JSONField(name = "POST_ACCOUNT")
    @ParamDesc(path = "POST_ACCOUNT", cons = ConsType.CT001, len = "30", desc = "局方托收银行帐户", type = "string", memo = "略")
    private String postAccount;

    @JSONField(name = "CITY_CODE")
    @ParamDesc(path = "CITY_CODE", cons = ConsType.CT001, len = "6", desc = "城市代码", type = "string", memo = "略")
    private String cityCode;

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public long getPayFee() {
        return payFee;
    }

    public void setPayFee(long payFee) {
        this.payFee = payFee;
    }

    public int getBillCycle() {
        return billCycle;
    }

    public void setBillCycle(int billCycle) {
        this.billCycle = billCycle;
    }

    public String getPostAccount() {
        return postAccount;
    }

    public void setPostAccount(String postAccount) {
        this.postAccount = postAccount;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }
}
