package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 作用：短信查询帐单展示费用实体
 * Created by wangyla on 2016/7/21.
 */
public class SmsBillFeeEntity implements Serializable {
    @JSONField(name = "FEE_TYPE")
    @ParamDesc(path = "FEE_TYPE" ,desc = "实体储存数据类型", cons = ConsType.CT001, len = "1", type = "String", memo = "0：汇总信息；1：往月客户费用；2：往月移动费用")
    private String feeType;
    @JSONField(name = "FEE1")
    @ParamDesc(path = "FEE1" ,desc = "套餐及固定费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee1;
    @JSONField(name = "FEE2")
    @ParamDesc(path = "FEE2" ,desc = "语音通信费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee2;
    @JSONField(name = "FEE3")
    @ParamDesc(path = "FEE3" ,desc = "可视电话通信费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee3;
    @JSONField(name = "FEE4")
    @ParamDesc(path = "FEE4" ,desc = "上网费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee4;
    @JSONField(name = "FEE5")
    @ParamDesc(path = "FEE5" ,desc = "短信及彩信费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee5;
    @JSONField(name = "FEE6")
    @ParamDesc(path = "FEE6" ,desc = "自有增值业务费（A类）", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee6;
    @JSONField(name = "FEE7")
    @ParamDesc(path = "FEE7" ,desc = "自有增值业务费（B类）", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee7;
    @JSONField(name = "FEE8")
    @ParamDesc(path = "FEE8" ,desc = "集团业务费", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee8;
    @JSONField(name = "FEE9")
    @ParamDesc(path = "FEE9" ,desc = "代收业务费用", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee9;
    @JSONField(name = "FEE10")
    @ParamDesc(path = "FEE10" ,desc = "其他费用", cons = ConsType.CT001, len = "14", type = "long", memo = "单位：分")
    private long fee10;

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public long getFee1() {
        return fee1;
    }

    public void setFee1(long fee1) {
        this.fee1 = fee1;
    }

    public long getFee2() {
        return fee2;
    }

    public void setFee2(long fee2) {
        this.fee2 = fee2;
    }

    public long getFee3() {
        return fee3;
    }

    public void setFee3(long fee3) {
        this.fee3 = fee3;
    }

    public long getFee4() {
        return fee4;
    }

    public void setFee4(long fee4) {
        this.fee4 = fee4;
    }

    public long getFee5() {
        return fee5;
    }

    public void setFee5(long fee5) {
        this.fee5 = fee5;
    }

    public long getFee6() {
        return fee6;
    }

    public void setFee6(long fee6) {
        this.fee6 = fee6;
    }

    public long getFee7() {
        return fee7;
    }

    public void setFee7(long fee7) {
        this.fee7 = fee7;
    }

    public long getFee8() {
        return fee8;
    }

    public void setFee8(long fee8) {
        this.fee8 = fee8;
    }

    public long getFee9() {
        return fee9;
    }

    public void setFee9(long fee9) {
        this.fee9 = fee9;
    }

    public long getFee10() {
        return fee10;
    }

    public void setFee10(long fee10) {
        this.fee10 = fee10;
    }
}
