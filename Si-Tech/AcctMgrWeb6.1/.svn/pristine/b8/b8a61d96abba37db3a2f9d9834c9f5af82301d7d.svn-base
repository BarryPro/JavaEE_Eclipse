package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.BankBillDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/12/27.
 */
public class SBankBillQueryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "BILL_LIST", cons = ConsType.QUES, type = "complex", len = "", desc = "银行展示帐单列表", memo = "")
    List<BankBillDispEntity> billList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("billList"), billList);
        return result;
    }

    public List<BankBillDispEntity> getBillList() {
        return billList;
    }

    public void setBillList(List<BankBillDispEntity> billList) {
        this.billList = billList;
    }
}
