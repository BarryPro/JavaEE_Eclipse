package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by liangrui on 2016/12/28.
 * 补托收入参中的数据实体
 */
@SuppressWarnings("serial")
public class CollEntity implements Serializable{
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path="CONTRACT_NO",cons= ConsType.CT001,type="String",len="18",desc="托收帐户号码",memo="略")
    private long contractNo;

    @JSONField(name = "PAY_FEE")
    @ParamDesc(path="PAY_FEE",cons= ConsType.CT001,type="String",len="14",desc="托收金额",memo="略")
    private long payFee;

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

    @Override
    public String toString() {
        return "CollEntity{" +
                "contractNo=" + contractNo +
                ", payFee=" + payFee +
                '}';
    }
}
