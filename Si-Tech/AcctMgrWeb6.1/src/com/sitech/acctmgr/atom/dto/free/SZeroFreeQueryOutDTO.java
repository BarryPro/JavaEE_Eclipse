package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/22.
 */
public class SZeroFreeQueryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "TOTAL_FEE", desc = "底线总金额", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long totalFee;

    @ParamDesc(path = "BASE_CONSUME_FEE", desc = "底线已消费金额", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long baseConsumeFee;

    @ParamDesc(path = "BASE_REMAIN_FEE", desc = "底线剩余金额", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long baseRemainFee;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("totalFee"), totalFee);
        result.setRoot(getPathByProperName("baseConsumeFee"), baseConsumeFee);
        result.setRoot(getPathByProperName("baseRemainFee"), baseRemainFee);

        return result;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

    public long getBaseConsumeFee() {
        return baseConsumeFee;
    }

    public void setBaseConsumeFee(long baseConsumeFee) {
        this.baseConsumeFee = baseConsumeFee;
    }

    public long getBaseRemainFee() {
        return baseRemainFee;
    }

    public void setBaseRemainFee(long baseRemainFee) {
        this.baseRemainFee = baseRemainFee;
    }
}
