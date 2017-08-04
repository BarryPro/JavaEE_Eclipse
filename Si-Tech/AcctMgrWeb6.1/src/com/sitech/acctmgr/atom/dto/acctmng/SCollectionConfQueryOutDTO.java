package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.collection.CollectionConf;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/8.
 */
public class SCollectionConfQueryOutDTO extends CommonOutDTO {

    /*@JSONField(name = "CONF_LIST")
    @ParamDesc(path="CONF_LIST",cons= ConsType.PLUS,type="compx",len="",desc="区县托收配置列表",memo="略")
    private List<CollectionConf> confList;*/

    @JSONField(name = "ENTER_CODE")
    @ParamDesc(path="ENTER_CODE",cons= ConsType.CT001,type="string",len="5",desc="企业代码",memo="略")
    private String enterCode;

    @JSONField(name = "OPER_TYPE")
    @ParamDesc(path="OPER_TYPE",cons= ConsType.CT001,type="string",len="5",desc="费用代码",memo="略")
    private String operType;

    @Override
    public MBean encode() {
        MBean result = super.encode();

        //result.setRoot(getPathByProperName("confList"),confList);
        result.setRoot(getPathByProperName("enterCode"),enterCode);
        result.setRoot(getPathByProperName("operType"),operType);
        return result;
    }

    /*public List<CollectionConf> getConfList() {
        return confList;
    }

    public void setConfList(List<CollectionConf> confList) {
        this.confList = confList;
    }*/

    public String getEnterCode() {
        return enterCode;
    }

    public void setEnterCode(String enterCode) {
        this.enterCode = enterCode;
    }

    public String getOperType() {
        return operType;
    }

    public void setOperType(String operType) {
        this.operType = operType;
    }
}
