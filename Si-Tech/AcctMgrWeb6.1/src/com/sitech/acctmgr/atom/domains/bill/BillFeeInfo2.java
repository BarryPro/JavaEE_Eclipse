package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 功能：七大类费用封装，含应收、优惠及实收费用
 * Created by wangyla on 2016/7/27.
 */
public class BillFeeInfo2 {

    @ParamDesc(path="FIXED_FEE", cons= ConsType.CT001, type="complex", len="", desc="套餐及固定费", memo="")
    private BillFeeEntity fixedFee;

    @JSONField(name = "CALL_FEE")
    @ParamDesc(path="CALL_FEE", cons= ConsType.CT001, type="complex", len="", desc="语音通信费", memo="")
    private BillFeeEntity callFee;

    @JSONField(name = "VIDEO_FEE")
    @ParamDesc(path="VIDEO_FEE", cons= ConsType.CT001, type="complex", len="", desc="可视电话费", memo="")
    private BillFeeEntity videoFee;

    @JSONField(name = "NET_FEE")
    @ParamDesc(path="NET_FEE", cons= ConsType.CT001, type="complex", len="", desc="上网费", memo="")
    private BillFeeEntity netFee;

    @JSONField(name = "MSG_FEE")
    @ParamDesc(path="MSG_FEE", cons= ConsType.CT001, type="complex", len="", desc="短彩信费", memo="")
    private BillFeeEntity msgFee;

    @JSONField(name = "SP_FEE")
    @ParamDesc(path="SP_FEE", cons= ConsType.CT001, type="complex", len="", desc="自有增值业务费", memo="")
    private BillFeeEntity spFee;

    @JSONField(name = "GROUP_FEE")
    @ParamDesc(path="GROUP_FEE", cons= ConsType.CT001, type="complex", len="", desc="集团业务费", memo="")
    private BillFeeEntity groupFee;

    @JSONField(name = "PROXY_FEE")
    @ParamDesc(path="PROXY_FEE", cons= ConsType.CT001, type="complex", len="", desc="代收费业务费", memo="")
    private BillFeeEntity proxyFee;

    @JSONField(name = "OTHRER_FEE")
    @ParamDesc(path="OTHRER_FEE", cons= ConsType.CT001, type="complex", len="", desc="其他费", memo="")
    private BillFeeEntity otherFee;

    @JSONField(name = "TOTAL_FEE")
    @ParamDesc(path="TOTAL_FEE", cons= ConsType.CT001, type="complex", len="", desc="总费用", memo="")
    private BillFeeEntity totalFee;

    @JSONField(name = "FAVOUR_FEE")
    @ParamDesc(path="FAVOUR_FEE", cons= ConsType.CT001, type="complex", len="", desc="总优惠", memo="")
    private BillFeeEntity favourFee;

    public BillFeeEntity getFixedFee() {
        return fixedFee;
    }

    public void setFixedFee(BillFeeEntity fixedFee) {
        this.fixedFee = fixedFee;
    }

    public BillFeeEntity getCallFee() {
        return callFee;
    }

    public void setCallFee(BillFeeEntity callFee) {
        this.callFee = callFee;
    }

    public BillFeeEntity getMsgFee() {
        return msgFee;
    }

    public void setMsgFee(BillFeeEntity msgFee) {
        this.msgFee = msgFee;
    }

    public BillFeeEntity getNetFee() {
        return netFee;
    }

    public void setNetFee(BillFeeEntity netFee) {
        this.netFee = netFee;
    }

    public BillFeeEntity getSpFee() {
        return spFee;
    }

    public void setSpFee(BillFeeEntity spFee) {
        this.spFee = spFee;
    }

    public BillFeeEntity getProxyFee() {
        return proxyFee;
    }

    public void setProxyFee(BillFeeEntity proxyFee) {
        this.proxyFee = proxyFee;
    }

    public BillFeeEntity getOtherFee() {
        return otherFee;
    }

    public void setOtherFee(BillFeeEntity otherFee) {
        this.otherFee = otherFee;
    }

    public BillFeeEntity getVideoFee() {
        return videoFee;
    }

    public void setVideoFee(BillFeeEntity videoFee) {
        this.videoFee = videoFee;
    }

    public BillFeeEntity getGroupFee() {
        return groupFee;
    }

    public void setGroupFee(BillFeeEntity groupFee) {
        this.groupFee = groupFee;
    }

    public BillFeeEntity getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(BillFeeEntity totalFee) {
        this.totalFee = totalFee;
    }

    public BillFeeEntity getFavourFee() {
        return favourFee;
    }

    public void setFavourFee(BillFeeEntity favourFee) {
        this.favourFee = favourFee;
    }

    @Override
    public String toString() {
        return "BillFeeInfo2{" +
                "fixedFee=" + fixedFee +
                ", callFee=" + callFee +
                ", videoFee=" + videoFee +
                ", netFee=" + netFee +
                ", msgFee=" + msgFee +
                ", spFee=" + spFee +
                ", groupFee=" + groupFee +
                ", proxyFee=" + proxyFee +
                ", otherFee=" + otherFee +
                ", totalFee=" + totalFee +
                ", favourFee=" + favourFee +
                '}';
    }
}
