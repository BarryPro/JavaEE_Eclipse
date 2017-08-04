package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/22.
 */
public class STdGprsQueryOutDTO extends CommonOutDTO{
    @ParamDesc(path = "TD_GPRS_DATA", desc = "用户当月通过TD网络产生的GPRS流量", cons = ConsType.CT001, type = "string", len = "20", memo = "单位：KB")
    private long tdGprsData;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("tdGprsData"), tdGprsData);
        return result;
    }

    public long getTdGprsData() {
        return tdGprsData;
    }

    public void setTdGprsData(long tdGprsData) {
        this.tdGprsData = tdGprsData;
    }
}
