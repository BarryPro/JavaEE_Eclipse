package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBalanceQueryInDTO extends CommonInDTO {


    private static final long serialVersionUID = 1L;
    @ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.QUES, type = "string", len = "2", desc = "查询类型", memo = "0:按服务号码查询, 1:按帐户查询, 2:按用户查询")
    private int qryType = 0;
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号码", memo = "略")
    private String phoneNo = "";
    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "string", len = "20", desc = "账户号码", memo = "略")
    private long contractNo = 0;
    @ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "string", len = "20", desc = "用户ID", memo = "略")
    private long idNo = 0;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("qryType")))) {
            qryType = Integer.valueOf(arg0.getStr(getPathByProperName("qryType")));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("phoneNo")))) {
            phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("contractNo")))) {
            contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
        }
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("idNo")))) {
            idNo = Long.valueOf(arg0.getStr(getPathByProperName("idNo")));
        }
    }


    public int getQryType() {
        return qryType;
    }

    public void setQryType(int qryType) {
        this.qryType = qryType;
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

    public long getIdNo() {
        return idNo;
    }

    public void setIdNo(long idNo) {
        this.idNo = idNo;
    }

}
