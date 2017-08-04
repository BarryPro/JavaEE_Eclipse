package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.StringUtils;

/**
 * Created by wangyla on 2016/12/22.
 */
public class SGroupConQueryInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.QUES, desc = "集团编码", len = "14", type = "string", memo = "手机号码")
    private long unitId;

    @ParamDesc(path = "BUSI_INFO.CUST_ID", cons = ConsType.QUES, desc = "集团客户ID", len = "18", type = "string", memo = "手机号码")
    private long custId;

    @ParamDesc(path = "BUSI_INFO.ID_ICCID", cons = ConsType.QUES, desc = "集团证件号码", len = "50", type = "string", memo = "手机号码")
    private String idIccid;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);

        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("unitId")))) {
            unitId = Long.parseLong(arg0.getStr(getPathByProperName("unitId")));
        }

        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("custId")))) {
            custId = Long.parseLong(arg0.getStr(getPathByProperName("custId")));
        }

        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("idIccid")))) {
            idIccid = arg0.getStr(getPathByProperName("idIccid"));
        }

    }

    public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }

    public long getCustId() {
        return custId;
    }

    public void setCustId(long custId) {
        this.custId = custId;
    }

    public String getIdIccid() {
        return idIccid;
    }

    public void setIdIccid(String idIccid) {
        this.idIccid = idIccid;
    }
}
