package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class S8225QryCollBillByConInDTO extends CommonInDTO {

    private static final long serialVersionUID = -5257181109666282034L;

    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "帐户号码", len = "18", type = "string", memo = "略")
    private long contractNo = 0;
    @ParamDesc(path = "BUSI_INFO.BILL_CYCLE", cons = ConsType.CT001, desc = "查询帐期", len = "6", type = "string", memo = "略")
    private int billCycle = 0;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
        billCycle = Integer.parseInt(arg0.getStr(getPathByProperName("billCycle")));
    }

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
}
