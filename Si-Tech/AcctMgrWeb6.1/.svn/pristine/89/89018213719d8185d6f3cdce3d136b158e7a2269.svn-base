package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.collection.CollBillInfoEntity;
import com.sitech.acctmgr.atom.domains.collection.CollOweStatusGroupEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;


public class S8225QryCollBillOutDTO extends CommonOutDTO {
    private static final long serialVersionUID = 2197443837604077322L;

    @JSONField(name = "BILL_LIST")
    @ParamDesc(path = "BILL_LIST", cons = ConsType.CT001, desc = "按服务号码展示托收费用列表", len = "", type = "complex", memo = "略")
    private List<CollOweStatusGroupEntity> collBillList = new ArrayList<CollOweStatusGroupEntity>();

    @JSONField(name = "BILL_INFO")
    @ParamDesc(path = "BILL_INFO", cons = ConsType.CT001, desc = "托收单基本信息", len = "", type = "complex", memo = "略")
    private CollBillInfoEntity collBillInfo = new CollBillInfoEntity();

    @JSONField(name = "BILL_LIST_CNT")
    @ParamDesc(path = "BILL_LIST_CNT", cons = ConsType.CT001, desc = "托收账单总数", len = "8", type = "int", memo = "略")
    private int collBillCnt;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("collBillList"), collBillList);
        result.setRoot(getPathByProperName("collBillInfo"), collBillInfo);
        result.setRoot(getPathByProperName("collBillCnt"), collBillCnt);
        return result;
    }

    public CollBillInfoEntity getCollBillInfo() {
        return collBillInfo;
    }

    public void setCollBillInfo(CollBillInfoEntity collBillInfo) {
        this.collBillInfo = collBillInfo;
    }

    public List<CollOweStatusGroupEntity> getCollBillList() {
        return collBillList;
    }

    public void setCollBillList(List<CollOweStatusGroupEntity> collBillList) {
        this.collBillList = collBillList;
    }

    public int getCollBillCnt() {
        return collBillCnt;
    }

    public void setCollBillCnt(int collBillCnt) {
        this.collBillCnt = collBillCnt;
    }

}
