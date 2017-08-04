package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.atom.domains.free.FlowDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/14.
 */
public class SFreeFlowDetailQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path="FLOW_LIST",cons= ConsType.STAR,type="complex",len="1",desc="统付流量明细",memo="列表，子节点流量单位为MB")
    private List<FlowDetailEntity> flowList;

    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("flowList"), flowList);
        return result;
    }

    public List<FlowDetailEntity> getFlowList() {
        return flowList;
    }

    public void setFlowList(List<FlowDetailEntity> flowList) {
        this.flowList = flowList;
    }
}
