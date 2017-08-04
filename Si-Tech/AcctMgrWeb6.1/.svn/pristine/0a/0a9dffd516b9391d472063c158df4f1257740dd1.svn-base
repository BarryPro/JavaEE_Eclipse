package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/21.
 */
public class SFreeGprsQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "GPRS_TOTAL")
    @ParamDesc(path = "GPRS_TOTAL", cons = ConsType.CT001, len = "12", desc = "应优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String gprsTotal;

    @JSONField(name = "GPRS_USED")
    @ParamDesc(path = "GPRS_USED", cons = ConsType.CT001, len = "12", desc = "已优惠量", type = "String", memo = "单位：MB 或 GB+MB")
    private String gprsUsed;

    @JSONField(name = "GPRS_REMAIN")
    @ParamDesc(path = "GPRS_REMAIN", cons = ConsType.CT001, len = "12", desc = "剩余优惠量", type = "String", memo = "单位：MB 或 GB+MB")
    private String gprsRemain;

    @JSONField(name = "OUT_GPRS_TOTAL")
    @ParamDesc(path = "OUT_GPRS_TOTAL", cons = ConsType.CT001, len = "12", desc = "套餐外总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String outGprsTotal;

    @JSONField(name = "GPRS_3G_TOTAL")
    @ParamDesc(path = "GPRS_3G_TOTAL", cons = ConsType.CT001, len = "12", desc = "3G总流量", type = "String", memo = "单位：MB 或 GB+MB")
    private String gprs3GTotal;

    @JSONField(name = "GRP_SHARED_GPRS_TOTAL")
    @ParamDesc(path = "GRP_SHARED_GPRS_TOTAL", cons = ConsType.CT001, len = "12", desc = "集团共享流量总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String grpSharedGprsTotal;

    @JSONField(name = "GRP_SHARED_GPRS_USED")
    @ParamDesc(path = "GRP_SHARED_GPRS_USED", cons = ConsType.CT001, len = "12", desc = "集团共享流量已使用量", type = "String", memo = "单位：MB 或 GB+MB")
    private String grpSharedGprsUsed;

    @JSONField(name = "GRP_SHARED_UNITY_USED")
    @ParamDesc(path = "GRP_SHARED_UNITY_USED", cons = ConsType.CT001, len = "12", desc = "集团共享流量个人已使用量", type = "String", memo = "单位：MB 或 GB+MB")
    private String grpSharedUnityUsed;

    @JSONField(name = "GPRS_TYPE_FLAG")
    @ParamDesc(path = "GPRS_TYPE_FLAG", cons = ConsType.CT001, len = "1", desc = "流量类型标识", type = "String", memo = "1：集团流量；0：default")
    private String gprsTypeFlag;

    @JSONField(name = "FLOW_FLAG")
    @ParamDesc(path = "FLOW_FLAG", cons = ConsType.CT001, len = "1", desc = "是否含有统付流量标识", type = "String", memo = "1：含有统付流量；0：不含统付流量")
    private String flowFlag;

    @JSONField(name = "VPMN_TOTAL")
    @ParamDesc(path = "VPMN_TOTAL", cons = ConsType.CT001, len = "12", desc = "VPMN总量", type = "String", memo = "单位：分钟")
    private String vpmnTotal;

    @JSONField(name = "VPMN_USED")
    @ParamDesc(path = "VPMN_USED", cons = ConsType.CT001, len = "12", desc = "VPMN已使用量", type = "String", memo = "单位：分钟")
    private String vpmnUsed;

    @JSONField(name = "VPMN_REMAIN")
    @ParamDesc(path = "VPMN_REMAIN", cons = ConsType.CT001, len = "12", desc = "VPMN剩余量", type = "String", memo = "单位：分钟")
    private String vpmnRemain;

    @JSONField(name = "MEMBER_FLAG")
    @ParamDesc(path = "MEMBER_FLAG", cons = ConsType.CT001, len = "12", desc = "副卡共享标识", type = "String", memo = "0：代表副卡;1：代表主卡")
    private String memberFlag;

    @JSONField(name = "MEMBER_SHARED_USED")
    @ParamDesc(path = "MEMBER_SHARED_USED", cons = ConsType.CT001, len = "12", desc = "副卡4G共享使用量", type = "String", memo = "单位：MB 或 GB+MB")
    private String memberSharedUsed;

    @JSONField(name = "MEMBER_SHARED_REMAIN")
    @ParamDesc(path = "MEMBER_SHARED_REMAIN", cons = ConsType.CT001, len = "12", desc = "副卡剩余共享", type = "String", memo = "单位：MB 或 GB+MB")
    private String memberSharedRemain;

    @JSONField(name="UNIT_NAME")
    @ParamDesc(path="UNIT_NAME",cons=ConsType.CT001,type="String",len="5",desc="流量单位名称",memo="MB 或 GB+MB")
    private String unitName;

    @JSONField(name = "FREE_INFO")
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "个人优惠信息明细", memo = "列表；套餐内及套餐外流量；不含集团共享流量；子节点流量单位：MB")
    private List<FreeDetailEntity> freeList;


    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("gprsTotal"), gprsTotal);
        result.setRoot(getPathByProperName("gprsUsed"), gprsUsed);
        result.setRoot(getPathByProperName("gprsRemain"), gprsRemain);
        result.setRoot(getPathByProperName("outGprsTotal"), outGprsTotal);
        result.setRoot(getPathByProperName("gprs3GTotal"), gprs3GTotal);
        result.setRoot(getPathByProperName("grpSharedGprsTotal"), grpSharedGprsTotal);
        result.setRoot(getPathByProperName("grpSharedGprsUsed"), grpSharedGprsUsed);
        result.setRoot(getPathByProperName("grpSharedUnityUsed"), grpSharedUnityUsed);
        result.setRoot(getPathByProperName("gprsTypeFlag"), gprsTypeFlag);
        result.setRoot(getPathByProperName("flowFlag"), flowFlag);
        result.setRoot(getPathByProperName("vpmnTotal"), vpmnTotal);
        result.setRoot(getPathByProperName("vpmnUsed"), vpmnUsed);
        result.setRoot(getPathByProperName("vpmnRemain"), vpmnRemain);
        result.setRoot(getPathByProperName("memberFlag"), memberFlag);
        result.setRoot(getPathByProperName("memberSharedUsed"), memberSharedUsed);
        result.setRoot(getPathByProperName("memberSharedRemain"), memberSharedRemain);
        result.setRoot(getPathByProperName("unitName"), unitName);
        result.setRoot(getPathByProperName("freeList"), freeList);
        return result;
    }

    public String getGprsTotal() {
        return gprsTotal;
    }

    public void setGprsTotal(String gprsTotal) {
        this.gprsTotal = gprsTotal;
    }

    public String getGprsUsed() {
        return gprsUsed;
    }

    public void setGprsUsed(String gprsUsed) {
        this.gprsUsed = gprsUsed;
    }

    public String getGprsRemain() {
        return gprsRemain;
    }

    public void setGprsRemain(String gprsRemain) {
        this.gprsRemain = gprsRemain;
    }

    public String getOutGprsTotal() {
        return outGprsTotal;
    }

    public void setOutGprsTotal(String outGprsTotal) {
        this.outGprsTotal = outGprsTotal;
    }

    public String getGprs3GTotal() {
        return gprs3GTotal;
    }

    public void setGprs3GTotal(String gprs3GTotal) {
        this.gprs3GTotal = gprs3GTotal;
    }

    public String getGrpSharedGprsTotal() {
        return grpSharedGprsTotal;
    }

    public void setGrpSharedGprsTotal(String grpSharedGprsTotal) {
        this.grpSharedGprsTotal = grpSharedGprsTotal;
    }

    public String getGrpSharedGprsUsed() {
        return grpSharedGprsUsed;
    }

    public void setGrpSharedGprsUsed(String grpSharedGprsUsed) {
        this.grpSharedGprsUsed = grpSharedGprsUsed;
    }

    public String getGrpSharedUnityUsed() {
        return grpSharedUnityUsed;
    }

    public void setGrpSharedUnityUsed(String grpSharedUnityUsed) {
        this.grpSharedUnityUsed = grpSharedUnityUsed;
    }

    public String getGprsTypeFlag() {
        return gprsTypeFlag;
    }

    public void setGprsTypeFlag(String gprsTypeFlag) {
        this.gprsTypeFlag = gprsTypeFlag;
    }

    public String getFlowFlag() {
        return flowFlag;
    }

    public void setFlowFlag(String flowFlag) {
        this.flowFlag = flowFlag;
    }

    public String getVpmnTotal() {
        return vpmnTotal;
    }

    public void setVpmnTotal(String vpmnTotal) {
        this.vpmnTotal = vpmnTotal;
    }

    public String getVpmnUsed() {
        return vpmnUsed;
    }

    public void setVpmnUsed(String vpmnUsed) {
        this.vpmnUsed = vpmnUsed;
    }

    public String getVpmnRemain() {
        return vpmnRemain;
    }

    public void setVpmnRemain(String vpmnRemain) {
        this.vpmnRemain = vpmnRemain;
    }

    public String getMemberFlag() {
        return memberFlag;
    }

    public void setMemberFlag(String memberFlag) {
        this.memberFlag = memberFlag;
    }

    public String getMemberSharedUsed() {
        return memberSharedUsed;
    }

    public void setMemberSharedUsed(String memberSharedUsed) {
        this.memberSharedUsed = memberSharedUsed;
    }

    public String getMemberSharedRemain() {
        return memberSharedRemain;
    }

    public void setMemberSharedRemain(String memberSharedRemain) {
        this.memberSharedRemain = memberSharedRemain;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public List<FreeDetailEntity> getFreeList() {
        return freeList;
    }

    public void setFreeList(List<FreeDetailEntity> freeList) {
        this.freeList = freeList;
    }
}
