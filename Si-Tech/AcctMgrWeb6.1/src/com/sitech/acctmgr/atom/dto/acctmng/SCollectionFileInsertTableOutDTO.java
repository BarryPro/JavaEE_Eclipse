package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/7.
 */
public class SCollectionFileInsertTableOutDTO extends CommonOutDTO{

    @JSONField(name = "RECD_NUM")
    @ParamDesc(path = "RECD_NUM", cons = ConsType.CT001, type = "int", len = "8", desc = "托收回销记录数", memo = "略")
    private int recdNum;

    @JSONField(name = "TOTAL_FEE")
    @ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "14", desc = "托收回销总金额", memo = "略")
    private long totalFee;

    @Override
    public MBean encode() {
        MBean result = super.encode();

        result.setRoot(getPathByProperName("recdNum"), recdNum);
        result.setRoot(getPathByProperName("totalFee"), totalFee);

        return result;
    }

    public int getRecdNum() {
        return recdNum;
    }

    public void setRecdNum(int recdNum) {
        this.recdNum = recdNum;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }
}
