package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/3/10.
 */
public class SGrpBillSixQueryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, len="18", type = "String", desc = "集团帐户号码", memo = "")
    private long contractNo;

    @Override
    public void decode(MBean arg0) {
        contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }
}
