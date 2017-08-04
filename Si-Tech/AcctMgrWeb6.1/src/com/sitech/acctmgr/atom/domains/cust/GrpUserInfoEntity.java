package com.sitech.acctmgr.atom.domains.cust;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Created by wangyla on 2016/8/9.
 */
public class GrpUserInfoEntity {
    @JSONField(name = "UNIT_ID")
    private Long unitId;

    @JSONField(name = "UNIT_NAME")
    private String unitName;

    @JSONField(name = "CONTACT_NAME")
    private String contactName;

    @JSONField(name = "CONTACT_PHONE")
    private String contactPhone;

    @JSONField(name = "CUST_ID")
    private long custId;

    public Long getUnitId() {
        return unitId;
    }

    public void setUnitId(Long unitId) {
        this.unitId = unitId;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public long getCustId() {
        return custId;
    }

    public void setCustId(long custId) {
        this.custId = custId;
    }

    @Override
    public String toString() {
        return "GrpUserInfoEntity{" +
                "unitId=" + unitId +
                ", unitName='" + unitName + '\'' +
                ", contactName='" + contactName + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", custId=" + custId +
                '}';
    }
}
