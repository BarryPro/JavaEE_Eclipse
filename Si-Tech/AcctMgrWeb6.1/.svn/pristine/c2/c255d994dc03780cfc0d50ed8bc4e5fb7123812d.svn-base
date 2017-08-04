package com.sitech.acctmgr.atom.domains.prod;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * Created by wangyla on 2017/2/28.
 */
public class UserGgPrcInfoEntity {
    @JSONField(name = "PRC_ID")
    @ParamDesc(path = "PRC_ID", type = "string", cons = ConsType.CT001, desc = "资费代码", len = "10", memo = "略")
    private String prcid;

    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", type = "string", cons = ConsType.CT001, desc = "资费名称", len = "10", memo = "略")
    private String prcName;

    @JSONField(name = "EFF_TIME")
    @ParamDesc(path = "EFF_TIME", type = "string", cons = ConsType.CT001, desc = "生效时间", len = "14", memo = "略")
    private String effTime;

    @JSONField(name = "EXP_TIME")
    @ParamDesc(path = "EXP_TIME", type = "string", cons = ConsType.CT001, desc = "失效时间", len = "14", memo = "略")
    private String expTime;

    public String getPrcid() {
        return prcid;
    }

    public void setPrcid(String prcid) {
        this.prcid = prcid;
    }

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
    }

    public String getEffTime() {
        return effTime;
    }

    public void setEffTime(String effTime) {
        this.effTime = effTime;
    }

    public String getExpTime() {
        return expTime;
    }

    public void setExpTime(String expTime) {
        this.expTime = expTime;
    }

    @Override
    public String toString() {
        return "UserGgPrcInfoEntity{" +
                "prcid='" + prcid + '\'' +
                ", prcName='" + prcName + '\'' +
                ", effTime='" + effTime + '\'' +
                ", expTime='" + expTime + '\'' +
                '}';
    }
}
