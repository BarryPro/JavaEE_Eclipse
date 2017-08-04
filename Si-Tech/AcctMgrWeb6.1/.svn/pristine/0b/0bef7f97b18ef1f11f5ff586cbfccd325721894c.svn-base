package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/12.
 */
public class SDetailDetailQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "BASE_INFO", cons = ConsType.CT001, len = "", type = "String", desc = "基础信息", memo = "略")
    private String baseInfo;

    @ParamDesc(path = "DETAIL_INFO", cons = ConsType.CT001, len = "", type = "compx", desc = "详单信息", memo = "数据实体，非List；")
    private ChannelDetail detail;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("detail"), detail);
        result.setRoot(getPathByProperName("baseInfo"), baseInfo);
        return result;
    }

    public String getBaseInfo() {
        return baseInfo;
    }

    public void setBaseInfo(String baseInfo) {
        this.baseInfo = baseInfo;
    }

    public ChannelDetail getDetail() {
        return detail;
    }

    public void setDetail(ChannelDetail detail) {
        this.detail = detail;
    }
}
