package com.sitech.acctmgr.atom.dto.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/2/10.
 */
public class SFamBillUnbillQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "DX_FLAG")
    @ParamDesc(path = "DX_FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "家庭状态标识", memo = "0-融合;1-底线")
    private String dxFlag;

    @JSONField(name = "PAY_UNBILL_FEE")
    @ParamDesc(path = "PAY_UNBILL_FEE", cons = ConsType.CT001, type = "String", len = "1", desc = "付费人未出帐话费总和", memo = "")
    private long payUnbillFee;

    @JSONField(name = "FAM_UNBILL_FEE")
    @ParamDesc(path = "FAM_UNBILL_FEE", cons = ConsType.CT001, type = "String", len = "1", desc = "家庭用户未出帐话费", memo = "")
    private long famUnbillFee;

    @JSONField(name = "NET_UNBILL_FEE")
    @ParamDesc(path = "NET_UNBILL_FEE", cons = ConsType.CT001, type = "String", len = "1", desc = "家庭宽带未出帐话费", memo = "")
    private long netUnbillFee;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("dxFlag"), dxFlag);
        result.setRoot(getPathByProperName("payUnbillFee"), payUnbillFee);
        result.setRoot(getPathByProperName("famUnbillFee"), famUnbillFee);
        result.setRoot(getPathByProperName("netUnbillFee"), netUnbillFee);

        return result;
    }

    public String getDxFlag() {
        return dxFlag;
    }

    public void setDxFlag(String dxFlag) {
        this.dxFlag = dxFlag;
    }

    public long getPayUnbillFee() {
        return payUnbillFee;
    }

    public void setPayUnbillFee(long payUnbillFee) {
        this.payUnbillFee = payUnbillFee;
    }

    public long getFamUnbillFee() {
        return famUnbillFee;
    }

    public void setFamUnbillFee(long famUnbillFee) {
        this.famUnbillFee = famUnbillFee;
    }

    public long getNetUnbillFee() {
        return netUnbillFee;
    }

    public void setNetUnbillFee(long netUnbillFee) {
        this.netUnbillFee = netUnbillFee;
    }
}
