package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.collection.CollectionDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.PrtXmlEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2016/7/5.
 */
public class SCollectionOrderPrintOutDTO extends CommonOutDTO {
    private static final long serialVersionUID = -3800718480267153420L;

    @JSONField(name = "PRT_INFO")
    @ParamDesc(path = "PRT_INFO", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票打印模板列表", memo = "略")
    protected List<PrtXmlEntity> prtInfo = new ArrayList<PrtXmlEntity>();

    public List<PrtXmlEntity> getPrtInfo() {
        return prtInfo;
    }

    public void setPrtInfo(List<PrtXmlEntity> prtInfo) {
        this.prtInfo = prtInfo;
    }

    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("prtInfo"), prtInfo);
        return result;
    }
}
