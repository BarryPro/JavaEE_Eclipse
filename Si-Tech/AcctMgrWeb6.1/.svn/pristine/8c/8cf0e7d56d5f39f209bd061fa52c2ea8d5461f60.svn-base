package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2016/7/25.
 */
public class FamilyFunnyDispEntity implements Serializable {

    @JSONField(name = "LEVEL")
    @ParamDesc(path = "LEVEL", desc = "高中低档标识", cons = ConsType.CT001, len = "2", memo = "取值：0：低；1：中；2：高")
    private String level;

    @JSONField(name = "PROD_PRC_NAME")
    @ParamDesc(path = "PROD_PRC_NAME", desc = "套餐名称", cons = ConsType.CT001, len = "250", memo = "")
    private String prodPrcName;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", desc = "已使用量", cons = ConsType.CT001, type= "long", len = "14", memo = "单位：分钟")
    private long used;

    @JSONField(name = "FREE_FEE")
    @ParamDesc(path = "FREE_FEE", desc = "语音优惠费用", cons = ConsType.CT001, len = "14", memo = "单位：分")
    private long freeFee;

    @JSONField(name = "PK_RATE")
    @ParamDesc(path = "PK_RATE", desc = "击败率", cons = ConsType.CT001, len = "14", memo = "")
    private String pkRate;

    @JSONField(name = "MASTER_FLAG")
    @ParamDesc(path = "MASTER_FLAG", desc = "组网人标识", cons = ConsType.CT001, len = "2", memo = "0:表示家长；1：表示成员")
    private String masterFlag;

    @JSONField(name = "GROUP_TYPE")
    @ParamDesc(path = "GROUP_TYPE", desc = "亲情网类型", cons = ConsType.CT001, len = "2", memo = "0：亲情网；2：亲情网A；3：亲情网B；4：亲情网C；")
    private String groupType;

    @JSONField(name = "SUM_FREE_FEE")
    @ParamDesc(path = "SUM_FREE_FEE", desc = "总优惠费用", cons = ConsType.CT001, len = "14", memo = "只有查询往月时才有值")
    private long sumFreeFee;

    @JSONField(name = "SUM_USED")
    @ParamDesc(path = "SUM_USED", desc = "家庭成员总优惠使用量", cons = ConsType.CT001, len = "14", memo = "家长查询时且只有查询往月时才有值")
    private long sumUsed;

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getProdPrcName() {
        return prodPrcName;
    }

    public void setProdPrcName(String prodPrcName) {
        this.prodPrcName = prodPrcName;
    }

    public long getUsed() {
        return used;
    }

    public void setUsed(long used) {
        this.used = used;
    }

    public long getFreeFee() {
        return freeFee;
    }

    public void setFreeFee(long freeFee) {
        this.freeFee = freeFee;
    }

    public void setSumFreeFee(long sumFreeFee) {
        this.sumFreeFee = sumFreeFee;
    }

    public void setSumUsed(long sumUsed) {
        this.sumUsed = sumUsed;
    }

    public String getPkRate() {
        return pkRate;
    }

    public void setPkRate(String pkRate) {
        this.pkRate = pkRate;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    @Override
    public String toString() {
        return "FamilyFunnyDispEntity{" +
                "level='" + level + '\'' +
                ", prodPrcName='" + prodPrcName + '\'' +
                ", used='" + used + '\'' +
                ", pkRate='" + pkRate + '\'' +
                ", masterFlag='" + masterFlag + '\'' +
                ", groupType='" + groupType + '\'' +
                ", sumFreeFee=" + sumFreeFee +
                ", sumUsed=" + sumUsed +
                '}';
    }

}
