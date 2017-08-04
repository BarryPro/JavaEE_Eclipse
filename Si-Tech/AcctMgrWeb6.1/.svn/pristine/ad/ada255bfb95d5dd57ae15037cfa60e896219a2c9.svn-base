
/**
 * File：CollBillDetail.java
 * <p/>
 * Version：
 * Date：2015-3-13
 * Copyright Clarify:
 */

package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;


/**
 * @Description: 托收单统计时托收明细清单
 * @author: wangyla
 * @version:
 * @createTime: 2015-3-13 下午5:42:39
 */

public class CollBillDetailEntity implements Serializable {
    private static final long serialVersionUID = 8233841486313188264L;

    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "托收帐户号码", type = "long", memo = "略")
    private long contractNo;
    @JSONField(name = "RETURN_CODE")
    @ParamDesc(path = "RETURN_CODE", cons = ConsType.CT001, len = "4", desc = "托收返回代码", type = "long", memo = "略")
    private String returnCode;
    @JSONField(name = "COLL_NAME")
    @ParamDesc(path = "COLL_NAME", cons = ConsType.CT001, len = "20", desc = "托收状态", type = "string", memo = "略")
    private String collName;
    @JSONField(name = "PAY_NUM")
    @ParamDesc(path = "PAY_NUM", cons = ConsType.CT001, len = "4", desc = "托收用户数", type = "int", memo = "略")
    private int payNum;
    @JSONField(name = "PAY_FEE")
    @ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, len = "", desc = "托收金额", type = "long", memo = "略")
    private long payFee;
    @JSONField(name = "BILL_CYCLE")
    @ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, len = "6", desc = "托收帐期", type = "int", memo = "略")
    private int billCycle;

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getCollName() {
        return collName;
    }

    public void setCollName(String collName) {
        this.collName = collName;
    }

    public int getPayNum() {
        return payNum;
    }

    public void setPayNum(int payNum) {
        this.payNum = payNum;
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
}
