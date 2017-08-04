package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/2/23.
 */
public class SMmsFreeQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "MMS_TOTAL", cons = ConsType.CT001, len = "8", type = "long", desc = "彩信优惠总条数", memo = "")
    private long mmsTotal;

    @ParamDesc(path = "MMS_USED", cons = ConsType.CT001, len = "8", type = "long", desc = "已使用彩信优惠条数", memo = "")
    private long mmsUsed;

    @ParamDesc(path = "MMS_REMAIN", cons = ConsType.CT001, len = "8", type = "long", desc = "剩余彩信", memo = "")
    private long mmsRemain;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("mmsTotal"), mmsTotal);
        result.setRoot(getPathByProperName("mmsUsed"), mmsUsed);
        result.setRoot(getPathByProperName("mmsRemain"), mmsRemain);
        return result;
    }

    public long getMmsTotal() {
        return mmsTotal;
    }

    public void setMmsTotal(long mmsTotal) {
        this.mmsTotal = mmsTotal;
    }

    public long getMmsUsed() {
        return mmsUsed;
    }

    public void setMmsUsed(long mmsUsed) {
        this.mmsUsed = mmsUsed;
    }

    public long getMmsRemain() {
        return mmsRemain;
    }

    public void setMmsRemain(long mmsRemain) {
        this.mmsRemain = mmsRemain;
    }
}
