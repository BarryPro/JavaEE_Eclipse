package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.StringUtils;

public class S8164QryBillInDTO extends CommonInDTO {

    private static final long serialVersionUID = 1L;

    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
    private String phoneNo;

    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "帐户号码", len = "18", type = "string", memo = "略")
    private long contractNo;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, desc = "账务年月", len = "6", type = "string", memo = "略")
    private int yearMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("contractNo")))) {
            contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
        }
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

}
