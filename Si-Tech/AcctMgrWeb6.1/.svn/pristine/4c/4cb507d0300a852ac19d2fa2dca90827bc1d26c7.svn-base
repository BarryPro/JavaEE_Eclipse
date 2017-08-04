package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/5/10.
 */
public class SGMBalanceQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "CUR_DATE", cons = ConsType.CT001, type = "String", len = "20", desc = "查询时间", memo = "YYYYMMDDHH24MISS")
    private String curDate;

    @ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "预存", memo = "单位:分")
    private long prepayFee;

    @ParamDesc(path = "REMAIN_BALANCE", cons = ConsType.CT001, type = "long", len = "20", desc = "余额", memo = "单位:分")
    private long curBalance;

    @ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "30", desc = "滞纳金", memo = "单位:分")
    private long delayFee;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("curDate"), curDate);
        result.setRoot(getPathByProperName("prepayFee"), prepayFee);
        result.setRoot(getPathByProperName("curBalance"), curBalance);
        result.setRoot(getPathByProperName("delayFee"), delayFee);

        return result;
    }

    public String getCurDate() {
        return curDate;
    }

    public void setCurDate(String curDate) {
        this.curDate = curDate;
    }

    public long getPrepayFee() {
        return prepayFee;
    }

    public void setPrepayFee(long prepayFee) {
        this.prepayFee = prepayFee;
    }

    public long getCurBalance() {
        return curBalance;
    }

    public void setCurBalance(long curBalance) {
        this.curBalance = curBalance;
    }

    public long getDelayFee() {
        return delayFee;
    }

    public void setDelayFee(long delayFee) {
        this.delayFee = delayFee;
    }
}
