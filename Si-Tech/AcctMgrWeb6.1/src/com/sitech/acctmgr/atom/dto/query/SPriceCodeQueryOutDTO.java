package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPriceCodeQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "PRICE_NAME", desc = "资费名称", cons = ConsType.CT001, type = "String", len = "60", memo = "")
    private String priceName;

    @ParamDesc(path = "PRICE_FEE", desc = "资费费用", cons = ConsType.CT001, type = "long", len = "14", memo = "")
    private long priceFee;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("priceName"), priceName);
        result.setRoot(getPathByProperName("priceFee"), priceFee);

        return result;
    }

    public String getPriceName() {
        return priceName;
    }

    public void setPriceName(String priceName) {
        this.priceName = priceName;
    }

    public long getPriceFee() {
        return priceFee;
    }

    public void setPriceFee(long priceFee) {
        this.priceFee = priceFee;
    }
}
