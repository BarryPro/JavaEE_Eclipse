package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/11/23.
 */
public class SGrpBillQueryInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, len="14", type = "String", desc = "集团编码", memo = "")
    private long unitId;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, desc = "账务年月", len = "6", type = "string", memo = "略")
    private int yearMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        unitId = Long.parseLong(arg0.getStr(getPathByProperName("unitId")));
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
    }

    public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }
}
