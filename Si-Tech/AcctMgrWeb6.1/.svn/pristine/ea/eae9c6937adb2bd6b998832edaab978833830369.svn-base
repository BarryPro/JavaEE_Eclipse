package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/7.
 */
public class SCollectionFileInsertTableInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, len = "6", type = "int", desc = "托收帐期", memo = "格式：YYYYMM")
    private int yearMonth;

	@Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));

    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }
}
