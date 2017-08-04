package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author JIASSA
 * @version 1.0
 */

public class S8295InitInDTO  extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.ID_ICCID", cons = ConsType.CT001, desc = "证件号码", len = "14", type = "long", memo = "略")
    private long  idIccid;
    
    @ParamDesc(path = "BUSI_INFO.CUST_ID", cons = ConsType.CT001, desc = "集团客户编码", len = "14", type = "long", memo = "略")
    private long  custId;
    
    @ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, desc = "集团编码", len = "14", type = "long", memo = "略")
    private long  unitId;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("unitId")))){
			setUnitId(Long.parseLong(arg0.getObject(getPathByProperName("unitId")).toString()));
		}else {
			unitId=0;
		}
        if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("custId")))){
			setCustId(Long.parseLong(arg0.getObject(getPathByProperName("custId")).toString()));
		}else {
			custId=0;
		}
        if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("idIccid")))){
			setIdIccid(Long.parseLong(arg0.getObject(getPathByProperName("idIccid")).toString()));
		}else {
			idIccid=0;
		}

    }

    public long getCustId() {
		return custId;
	}



	public void setCustId(long custId) {
		this.custId = custId;
	}



	public long getIdIccid() {
		return idIccid;
	}



	public void setIdIccid(long idIccid) {
		this.idIccid = idIccid;
	}



	public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }
}
