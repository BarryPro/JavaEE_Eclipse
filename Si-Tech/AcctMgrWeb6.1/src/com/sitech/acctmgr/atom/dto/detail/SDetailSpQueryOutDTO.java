package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.atom.domains.detail.DynamicTable;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2016/9/18.
 */
public class SDetailSpQueryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "BASE_INFO", cons = ConsType.CT001, len = "", type = "complex", desc = "基础信息", memo = "List<String>")
    private List<String> baseInfo;

    @ParamDesc(path = "DETAIL_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "详单列表", memo = "")
    private List<ChannelDetail> channelDetails = null;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("baseInfo"), baseInfo);
        result.setRoot(getPathByProperName("channelDetails"), channelDetails);
        return result;
    }

    public List<String> getBaseInfo() {
        return baseInfo;
    }

    public void setBaseInfo(List<String> baseInfo) {
        this.baseInfo = baseInfo;
    }

    public List<ChannelDetail> getChannelDetails() {
        return channelDetails;
    }

    public void setChannelDetails(List<ChannelDetail> channelDetails) {
        this.channelDetails = channelDetails;
    }
}
