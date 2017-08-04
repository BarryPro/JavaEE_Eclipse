package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/12/15.
 */
public class SGrpFreeShareQueryOutDTO extends CommonOutDTO {
    @JSONField(name="CONTRACT_NAME")
    @ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="集团产品名称",memo="")
    private String contractName;

    @JSONField(name="GRP_PHONE_NO")
    @ParamDesc(path="GRP_PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="集团产品号码",memo="指集团的虚拟号码")
    private String grpPhoneNo;

    @JSONField(name="CUST_NAME")
    @ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="100",desc="集团名称",memo="")
    private String custName;

    @JSONField(name = "OUT_TOTAL")
    @ParamDesc(path = "OUT_TOTAL", cons = ConsType.QUES, len = "", type = "String", desc = "套餐外GPRS流量总量", memo = "单位KB")
    private String outTotal;

    @JSONField(name = "GPRS_TOTAL")
    @ParamDesc(path = "GPRS_TOTAL", cons = ConsType.CT001, len = "12", desc = "应优惠共享流量总量", type = "String", memo = "K")
    private String gprsTotal;

    @JSONField(name = "GPRS_USED")
    @ParamDesc(path = "GPRS_USED", cons = ConsType.CT001, len = "12", desc = "已优惠共享流量总量", type = "String", memo = "K")
    private String gprsUsed;

    @JSONField(name="UNIT_NAME")
    @ParamDesc(path="UNIT_NAME",cons=ConsType.CT001,type="String",len="5",desc="流量单位名称",memo="")
    private String unitName;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("contractName"), contractName);
        result.setRoot(getPathByProperName("grpPhoneNo"), grpPhoneNo);
        result.setRoot(getPathByProperName("custName"), custName);
        result.setRoot(getPathByProperName("unitName"), unitName);
        result.setRoot(getPathByProperName("outTotal"), outTotal);
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);

        return result;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public String getGrpPhoneNo() {
        return grpPhoneNo;
    }

    public void setGrpPhoneNo(String grpPhoneNo) {
        this.grpPhoneNo = grpPhoneNo;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getOutTotal() {
        return outTotal;
    }

    public void setOutTotal(String outTotal) {
        this.outTotal = outTotal;
    }

    public String getGprsTotal() {
        return gprsTotal;
    }

    public void setGprsTotal(String gprsTotal) {
        this.gprsTotal = gprsTotal;
    }

    public String getGprsUsed() {
        return gprsUsed;
    }

    public void setGprsUsed(String gprsUsed) {
        this.gprsUsed = gprsUsed;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }
}
