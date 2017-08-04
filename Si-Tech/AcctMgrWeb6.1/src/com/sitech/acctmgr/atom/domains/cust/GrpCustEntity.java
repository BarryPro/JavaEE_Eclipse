package com.sitech.acctmgr.atom.domains.cust;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/3/13.
 * 集团客户属性实体
 */
public class GrpCustEntity implements Serializable {
    @JSONField(name = "UNIT_ID")
    @ParamDesc(path = "UNIT_ID", cons = ConsType.QUES, desc = "集团编码", len = "14", type = "string", memo = "")
    private long unitId;

    @JSONField(name = "CUST_ID")
    @ParamDesc(path = "CUST_ID", cons = ConsType.QUES, desc = "集团客户ID", len = "18", type = "string", memo = "")
    private long custId;

    @JSONField(name = "ID_ICCID")
    @ParamDesc(path = "ID_ICCID", cons = ConsType.QUES, desc = "集团证件号码", len = "50", type = "string", memo = "")
    private String idIccid;

    @JSONField(name = "CUST_NAME")
    @ParamDesc(path = "CUST_NAME", cons = ConsType.QUES, desc = "集团客户名称", len = "100", type = "string", memo = "")
    private String custName;

    @JSONField(name = "ID_TYPE_NAME")
    @ParamDesc(path = "ID_TYPE_NAME", cons = ConsType.QUES, desc = "证件类型名称", len = "100", type = "string", memo = "")
    private String idTypeName;

    @JSONField(name = "ID_TYPE")
    private String idType;

    public String getIdIccid() {
        return idIccid;
    }

    public void setIdIccid(String idIccid) {
        this.idIccid = idIccid;
    }

    public long getCustId() {
        return custId;
    }

    public void setCustId(long custId) {
        this.custId = custId;
    }

    public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getIdTypeName() {
        return idTypeName;
    }

    public void setIdTypeName(String idTypeName) {
        this.idTypeName = idTypeName;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    @Override
    public String toString() {
        return "GrpCustEntity{" +
                "unitId=" + unitId +
                ", custId=" + custId +
                ", idIccid='" + idIccid + '\'' +
                ", custName='" + custName + '\'' +
                ", idTypeName='" + idTypeName + '\'' +
                ", idType='" + idType + '\'' +
                '}';
    }
}
