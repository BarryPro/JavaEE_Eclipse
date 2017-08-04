package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8225CalCollBillInDTO extends CommonInDTO {

    private static final long serialVersionUID = -464528250041316396L;

    @ParamDesc(path = "BUSI_INFO.DIS_GROUP_ID", cons = ConsType.QUES, desc = "归属区县", len = "10", type = "string", memo = "略")
    private String disGroupId = "";
    @ParamDesc(path = "BUSI_INFO.RETURN_CODE", cons = ConsType.QUES, desc = "托收返回代码", len = "4", type = "string", memo = "略")
    private String collCode = "";
    @ParamDesc(path = "BUSI_INFO.BEGIN_CONTRACT_NO", cons = ConsType.CT001, desc = "开始帐户", len = "18", type = "string", memo = "略")
    private long beginContractNo = 0;
    @ParamDesc(path = "BUSI_INFO.END_CONTRACT_NO", cons = ConsType.CT001, desc = "结束帐户", len = "18", type = "string", memo = "略")
    private long endContractNo = 0;
    @ParamDesc(path = "BUSI_INFO.BILL_CYCLE", cons = ConsType.CT001, desc = "查询帐期", len = "6", type = "string", memo = "略")
    private int billCycle = 0;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        collCode = arg0.getStr(getPathByProperName("collCode"));
        disGroupId = arg0.getStr(getPathByProperName("disGroupId"));
        beginContractNo = Long.parseLong(arg0.getStr(getPathByProperName("beginContractNo")));
        endContractNo = Long.parseLong(arg0.getStr(getPathByProperName("endContractNo")));
        billCycle = Integer.parseInt(arg0.getStr(getPathByProperName("billCycle")));
    }

    public String getDisGroupId() {
        return disGroupId;
    }

    public void setDisGroupId(String disGroupId) {
        this.disGroupId = disGroupId;
    }

    public String getCollCode() {
        return collCode;
    }

    public void setCollCode(String collCode) {
        this.collCode = collCode;
    }

    public long getBeginContractNo() {
        return beginContractNo;
    }

    public void setBeginContractNo(long beginContractNo) {
        this.beginContractNo = beginContractNo;
    }

    public long getEndContractNo() {
        return endContractNo;
    }

    public void setEndContractNo(long endContractNo) {
        this.endContractNo = endContractNo;
    }

    public int getBillCycle() {
        return billCycle;
    }

    public void setBillCycle(int billCycle) {
        this.billCycle = billCycle;
    }

}
