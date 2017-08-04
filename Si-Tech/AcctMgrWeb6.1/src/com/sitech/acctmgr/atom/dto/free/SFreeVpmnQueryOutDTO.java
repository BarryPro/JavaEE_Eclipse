package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/22.
 */
public class SFreeVpmnQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "UNIT_ID", desc = "集团编码", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long unitId;

    @ParamDesc(path = "UNIT_NAME", desc = "集团名称", cons = ConsType.CT001, type = "String", len = "100", memo = "")
    private String unitName;

    @ParamDesc(path = "CONTACT_PERSON", desc = "客户经理名称", cons = ConsType.CT001, type = "String", len = "30", memo = "")
    private String contactPerson;

    @ParamDesc(path = "CONTACT_PHONE", desc = "客户经理电话", cons = ConsType.CT001, type = "String", len = "15", memo = "")
    private String contactPhone;

    @ParamDesc(path = "VPMN_TOTAL", desc = "应优惠vpmn分钟数", cons = ConsType.CT001, type = "long", len = "14", memo = "单位：分钟")
    private long vpmnTotal;

    @ParamDesc(path = "VPMN_USED", desc = "已优惠vpmn分钟数", cons = ConsType.CT001, type = "long", len = "14", memo = "单位：分钟")
    private long vpmnUsed;

    @ParamDesc(path = "VPMN_REMAIN", desc = "剩余vpmn分钟数", cons = ConsType.CT001, type = "long", len = "14", memo = "单位：分钟")
    private long vpmnRemain;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("unitId"), unitId);
        result.setRoot(getPathByProperName("unitName"), unitName);
        result.setRoot(getPathByProperName("contactPerson"), contactPerson);
        result.setRoot(getPathByProperName("contactPhone"), contactPhone);
        result.setRoot(getPathByProperName("vpmnTotal"), vpmnTotal);
        result.setRoot(getPathByProperName("vpmnUsed"), vpmnUsed);
        result.setRoot(getPathByProperName("vpmnRemain"), vpmnRemain);
        return result;
    }

    public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public long getVpmnTotal() {
        return vpmnTotal;
    }

    public void setVpmnTotal(long vpmnTotal) {
        this.vpmnTotal = vpmnTotal;
    }

    public long getVpmnUsed() {
        return vpmnUsed;
    }

    public void setVpmnUsed(long vpmnUsed) {
        this.vpmnUsed = vpmnUsed;
    }

    public long getVpmnRemain() {
        return vpmnRemain;
    }

    public void setVpmnRemain(long vpmnRemain) {
        this.vpmnRemain = vpmnRemain;
    }
}
