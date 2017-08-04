package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.cust.GrpCustEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/12/22.
 */
public class SGroupConQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "GRP_CUST_LIST")
    @ParamDesc(path = "GRP_CUST_LIST", cons = ConsType.QUES, type = "complex", len = "", desc = "集团客户列表", memo = "")
    private List<GrpCustEntity> grpCustList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("grpCustList"), grpCustList);
        return result;
    }

    public List<GrpCustEntity> getGrpCustList() {
        return grpCustList;
    }

    public void setGrpCustList(List<GrpCustEntity> grpCustList) {
        this.grpCustList = grpCustList;
    }
}
