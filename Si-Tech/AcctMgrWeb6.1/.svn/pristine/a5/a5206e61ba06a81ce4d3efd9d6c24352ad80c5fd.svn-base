package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title:  账单明细查询入参DTO</p>
 * <p>Description:   账单明细查询入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class S8102QryBillDetailInDTO extends CommonInDTO {
    private static final long serialVersionUID = -6265898958969556253L;
    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "String", len = "6", desc = "查询年月", memo = "格式：YYYYMM")
    private int yearMonth;
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
    private String phoneNo;
    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "String", len = "18", desc = "账户号码", memo = "可空")
    private long contractNo;

    @ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.QUES, type = "String", len = "5", desc = "账单查询类型", memo = "取值 all：所有帐单；TF：特服帐单；XXF：信息费账单；忽略大小写；")
    private String billQueryType;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        yearMonth = Integer.valueOf(arg0.getStr(getPathByProperName("yearMonth")));
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("contractNo")))) {
            contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
        }
        billQueryType = arg0.getStr(getPathByProperName("billQueryType"));

    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
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

    public String getBillQueryType() {
        return billQueryType;
    }

    public void setBillQueryType(String billQueryType) {
        this.billQueryType = billQueryType;
    }
}
