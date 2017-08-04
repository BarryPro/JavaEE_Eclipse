package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.PhoneBillEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/12/23.
 */
public class SPhoneBillQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "BILL_LIST", cons = ConsType.CT001, len = "", type = "compx", desc = "用户帐单明细", memo = "")
    List<PhoneBillEntity> billList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("billList"), billList);
        return result;
    }

    public List<PhoneBillEntity> getBillList() {
        return billList;
    }

    public void setBillList(List<PhoneBillEntity> billList) {
        this.billList = billList;
    }
}
