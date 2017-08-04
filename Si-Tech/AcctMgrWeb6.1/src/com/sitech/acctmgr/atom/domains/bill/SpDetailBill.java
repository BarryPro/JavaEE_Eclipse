package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * @author 代收费业务费明细
 */
public class SpDetailBill {

    @JSONField(name = "SERV_CODE")
    @ParamDesc(path = "SERV_CODE", cons = ConsType.CT001,len = "", type = "string",desc = "业务端口",memo = "")
    private String servCode;

    @JSONField(name = "OPER_CODE")
    @ParamDesc(path = "OPER_CODE",cons = ConsType.CT001,len = "",type = "string",desc = "业务代码", memo = "")
    private String operCode;

    @JSONField(name = "OPER_NAME")
    @ParamDesc(path = "OPER_NAME",cons = ConsType.CT001,len = "",type = "string",desc = "业务名称", memo = "")
    private String operName;

    @JSONField(name = "SP_CODE")
    @ParamDesc(path = "SP_CODE",cons = ConsType.CT001,len = "",type = "string",desc = "企业代码", memo = "")
    private String spCode;

    @JSONField(name = "SP_NAME")
    @ParamDesc(path = "SP_NAME",cons = ConsType.CT001,len = "",type = "string",desc = "企业名称", memo = "")
    private String spName;

    @JSONField(name = "SYSTEM_TYPE")
    @ParamDesc(path = "SYSTEM_TYPE",cons = ConsType.CT001,len = "",type = "string",desc = "数据类型", memo = "")
    private String systemType;

    @JSONField(name = "USE_TYPE")
    @ParamDesc(path = "USE_TYPE",cons = ConsType.CT001,len = "",type = "string",desc = "使用方式", memo = "")
    private String useType;

    @JSONField(name = "BILLING_TYPE")
    @ParamDesc(path = "BILLING_TYPE",cons = ConsType.CT001,len = "",type = "string",desc = "费用类型", memo = "")
    private String billingType;

    @JSONField(name = "OPER_FEE")
    @ParamDesc(path = "OPER_FEE",cons = ConsType.CT001,len = "",type = "long",desc = "金额", memo = "")
    private long operFee;

    public String getServCode() {
        return servCode;
    }

    public void setServCode(String servCode) {
        this.servCode = servCode;
    }

    public String getOperCode() {
        return operCode;
    }

    public void setOperCode(String operCode) {
        this.operCode = operCode;
    }

    public String getOperName() {
        return operName;
    }

    public void setOperName(String operName) {
        this.operName = operName;
    }

    public String getSpCode() {
        return spCode;
    }

    public void setSpCode(String spCode) {
        this.spCode = spCode;
    }

    public String getSpName() {
        return spName;
    }

    public void setSpName(String spName) {
        this.spName = spName;
    }

    public String getSystemType() {
        return systemType;
    }

    public void setSystemType(String systemType) {
        this.systemType = systemType;
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }

    public String getBillingType() {
        return billingType;
    }

    public void setBillingType(String billingType) {
        this.billingType = billingType;
    }

    public long getOperFee() {
        return operFee;
    }

    public void setOperFee(long operFee) {
        this.operFee = operFee;
    }

    @Override
    public String toString() {
        return "SpDetailBill{" +
                "servCode='" + servCode + '\'' +
                ", operCode='" + operCode + '\'' +
                ", operName='" + operName + '\'' +
                ", spCode='" + spCode + '\'' +
                ", spName='" + spName + '\'' +
                ", systemType='" + systemType + '\'' +
                ", useType='" + useType + '\'' +
                ", billingType='" + billingType + '\'' +
                ", operFee=" + operFee +
                '}';
    }
}
