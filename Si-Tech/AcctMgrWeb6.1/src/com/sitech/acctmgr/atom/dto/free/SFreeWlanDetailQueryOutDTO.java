package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeDetailEntity;
import com.sitech.acctmgr.atom.domains.free.FreeUseInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/18.
 */
public class SFreeWlanDetailQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "WLAN_TIME")
    @ParamDesc(path = "WLAN_TIME", cons = ConsType.CT001, len = "", type = "compx", desc = "wlan时长计量使用情况", memo = "非LIST;优惠量单位：分钟")
    private FreeUseInfoEntity wlanTime;

    @JSONField(name = "WLAN_GPRS")
    @ParamDesc(path = "WLAN_GPRS", cons = ConsType.CT001, len = "", type = "compx", desc = "wlan流量计量使用情况", memo = "非LIST；优惠量单位：MB")
    private FreeUseInfoEntity wlanGprs;

    @JSONField(name = "FREE_INFO")
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "wlan免费资源明细", memo = "list;时长的单位：分钟；流量的单位：MB")
    private List<FreeDetailEntity> wlanList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("wlanTime"), wlanTime);
        result.setRoot(getPathByProperName("wlanGprs"), wlanGprs);
        result.setRoot(getPathByProperName("wlanList"), wlanList);
        return result;
    }

    public FreeUseInfoEntity getWlanTime() {
        return wlanTime;
    }

    public void setWlanTime(FreeUseInfoEntity wlanTime) {
        this.wlanTime = wlanTime;
    }

    public FreeUseInfoEntity getWlanGprs() {
        return wlanGprs;
    }

    public void setWlanGprs(FreeUseInfoEntity wlanGprs) {
        this.wlanGprs = wlanGprs;
    }

    public List<FreeDetailEntity> getWlanList() {
        return wlanList;
    }

    public void setWlanList(List<FreeDetailEntity> wlanList) {
        this.wlanList = wlanList;
    }
}
