package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.atom.domains.collection.CollEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by liangrui on 2016/12/28.
 */
@SuppressWarnings("serial")
public class SCollectionFileCheckInDTO extends CommonInDTO{
    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, len = "6", type = "int", desc = "托收帐期", memo = "格式：YYYYMM")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.COLL_INFO", cons = ConsType.PLUS, len = "", type = "complex", desc = "补托帐户列表", memo = "帐户|金额")
    private List<CollEntity> collList;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
        collList = arg0.getList(getPathByProperName("collList"), CollEntity.class);
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public List<CollEntity> getCollList() {
        return collList;
    }

    public void setCollList(List<CollEntity> collList) {
        this.collList = collList;
    }
}
