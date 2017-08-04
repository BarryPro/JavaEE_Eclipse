package com.sitech.acctmgr.atom.dto.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.GrpBillKfEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/3/10.
 */
public class SGrpBillSixQueryOutDTO extends CommonOutDTO {
    @JSONField(name = "BILL_LIST")
    @ParamDesc(path = "BILL_LIST", cons = ConsType.QUES, type = "complex", len = "", desc = "集团产品近六月明细列表", memo = "")
    private List<GrpBillKfEntity> billList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("billList"), billList);
        return result;
    }

    public List<GrpBillKfEntity> getBillList() {
        return billList;
    }

    public void setBillList(List<GrpBillKfEntity> billList) {
        this.billList = billList;
    }
}
