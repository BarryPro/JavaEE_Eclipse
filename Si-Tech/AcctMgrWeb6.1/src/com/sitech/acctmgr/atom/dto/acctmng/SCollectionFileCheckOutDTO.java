package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by liangrui on 2016/12/28.
 */
public class SCollectionFileCheckOutDTO extends CommonOutDTO{
    @ParamDesc(path = "TOTAL_PAY_FEE", cons = ConsType.CT001, len = "14", type = "long", desc = "总托收金额", memo = "")
    private long totalPayFee;
    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("totalPayFee"), totalPayFee);
        return result;
    }

    public long getTotalPayFee() {
        return totalPayFee;
    }

    public void setTotalPayFee(long totalPayFee) {
        this.totalPayFee = totalPayFee;
    }
}
