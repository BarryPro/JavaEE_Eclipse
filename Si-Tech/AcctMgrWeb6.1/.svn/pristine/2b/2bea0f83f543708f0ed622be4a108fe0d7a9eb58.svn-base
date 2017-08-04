package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/7/8.
 */
public class CollectionConf implements Serializable{

    //@JSONField(name = "DIS_GROUP_ID")
    @JSONField( serialize = false)
    @ParamDesc(path="DIS_GROUP_ID",cons= ConsType.CT001,type="string",len="20",desc="区县代码",memo="略")
    private String disGroupId;

    @JSONField(name = "CITY_CODE")
    @ParamDesc(path="CITY_CODE",cons= ConsType.CT001,type="string",len="4",desc="入网城市代码",memo="略")
    private String cityCode;

    @JSONField(name = "OP_TYPE")
    @ParamDesc(path="OP_TYPE",cons= ConsType.CT001,type="string",len="2",desc="操作类型",memo="略")
    private String opType;

    @JSONField(name = "BUSI_CODE")
    @ParamDesc(path="BUSI_CODE",cons= ConsType.CT001,type="string",len="5",desc="业务类型",memo="对应oper_code")
    private String busiCode;

    @JSONField(name = "ENTER_CODE")
    @ParamDesc(path="ENTER_CODE",cons= ConsType.CT001,type="string",len="5",desc="企业代码",memo="略")
    private String enterCode;

    @JSONField(name = "OPER_TYPE")
    @ParamDesc(path="OPER_TYPE",cons= ConsType.CT001,type="string",len="5",desc="费用代码",memo="略")
    private String operType;

    public String getDisGroupId() {
        return disGroupId;
    }

    public void setDisGroupId(String disGroupId) {
        this.disGroupId = disGroupId;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getOpType() {
        return opType;
    }

    public void setOpType(String opType) {
        this.opType = opType;
    }

    public String getBusiCode() {
        return busiCode;
    }

    public void setBusiCode(String busiCode) {
        this.busiCode = busiCode;
    }

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

    @Override
    public String toString() {
        return "CollectionConf{" +
                "disGroupId='" + disGroupId + '\'' +
                ", opType='" + opType + '\'' +
                ", busiCode='" + busiCode + '\'' +
                ", enterCode='" + enterCode + '\'' +
                ", operType='" + operType + '\'' +
                '}';
    }
}
