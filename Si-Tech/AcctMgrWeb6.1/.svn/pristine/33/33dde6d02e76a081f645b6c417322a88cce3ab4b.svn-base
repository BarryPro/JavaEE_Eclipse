package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * Created by wangyla on 2017/6/7.
 */
public class FreeGprsDetailEntity implements Serializable {

    @JSONField(name = "gprs_product_num")
    @ParamDesc(path = "gprs_product_num", cons = ConsType.CT001, len = "2", desc = "产品个数", type = "String", memo = "同一产品个数")
    private int prcNum;

    @JSONField(name = "gprs_product_id")
    @ParamDesc(path = "gprs_product_id", cons = ConsType.CT001, len = "10", desc = "产品编码", type = "String", memo = "套餐的产品编码")
    private String prcId;

    @JSONField(name = "gprs_max_value")
    @ParamDesc(path = "gprs_max_value", cons = ConsType.CT001, len = "12", desc = "套餐总量", type = "String", memo = "按流量：单位K; 按时长：单位秒")
    private String gprsTotal;

    @JSONField(serialize = false)
    private long longGprsTotal;

    @JSONField(name = "gprs_cumulate_value")
    @ParamDesc(path = "gprs_cumulate_value", cons = ConsType.CT001, len = "12", desc = "套餐使用量", type = "String", memo = "按流量：单位K")
    private String gprsUsed;

    @JSONField(serialize = false)
    private long longGprsUsed;

    @JSONField(name = "gprs_product_name")
    @ParamDesc(path = "gprs_product_name", cons = ConsType.CT001, len = "256", desc = "套餐名称", type = "String", memo = "GPRS套餐产品描述")
    private String prcName;

    @JSONField(name = "gprs_product_type")
    @ParamDesc(path = "gprs_product_type", cons = ConsType.CT001, len = "1", desc = "套餐类型", type = "String", memo = "1半包套餐;2全包套餐")
    private String productType;

    @JSONField(name = "gprs_rate_type")
    @ParamDesc(path = "gprs_rate_type", cons = ConsType.CT001, len = "1", desc = "计费类型", type = "String", memo = "1按流量")
    private String rateType;

    @JSONField(name = "gprs_use_type")
    @ParamDesc(path = "gprs_use_type", cons = ConsType.CT001, len = "2", desc = "套餐使用类型", type = "String", memo = "0不区分、1省内、2国内、3国际、4T网、5非T网")
    private String useType;

    @JSONField(name = "gprs_net_type")
    @ParamDesc(path = "gprs_net_type", cons = ConsType.CT001, len = "1", desc = "网络类型", type = "String", memo = "1：通用（2G/3G/4G）;2:2G&3G;3:4G")
    private String netType;

    @JSONField(name = "gprs_send_type")
    @ParamDesc(path = "gprs_send_type", cons = ConsType.CT001, len = "1", desc = "是否可以转增", type = "String", memo = "0：可转赠;1：不可转赠")
    private String sendType;

    @JSONField(name = "gprs_share_type")
    @ParamDesc(path = "gprs_share_type", cons = ConsType.CT001, len = "1", desc = "是否可以共享", type = "String", memo = "0：可共享;1：不可共享")
    private String shareType;

    @JSONField(name = "gprs_import_type")
    @ParamDesc(path = "gprs_import_type", cons = ConsType.CT001, len = "1", desc = "是否可以结转", type = "String", memo = "0：结转资源；1：非结转资源(如按次计费产品、本月资源)")
    private String carryType;

    @JSONField(name = "gprs_cumulate _type")
    @ParamDesc(path = "gprs_cumulate _type", cons = ConsType.CT001, len = "1", desc = "GPRS累计类型", type = "String", memo = "0：按月累计；1：跨月累计（如小时包，季包，半年包，假日包等）")
    private String cumulateType;

    @JSONField(name = "begin_date")
    @ParamDesc(path = "begin_date", cons = ConsType.CT001, len = "8", desc = "累计量开始时间", type = "String", memo = "Yyyymmdd，跨月套餐的有值，按月的套餐值为空")
    private String beginDate;

    @JSONField(name = "end_date")
    @ParamDesc(path = "end_date", cons = ConsType.CT001, len = "8", desc = "累计量截止时间", type = "String", memo = "Yyyymmdd，跨月套餐的有值，按月的套餐值为空")
    private String endDate;

    public int getPrcNum() {
        return prcNum;
    }

    public void setPrcNum(int prcNum) {
        this.prcNum = prcNum;
    }

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public String getGprsTotal() {
        return gprsTotal;
    }

    public void setGprsTotal(String gprsTotal) {
        this.gprsTotal = gprsTotal;
    }

    public long getLongGprsTotal() {
        return longGprsTotal;
    }

    public void setLongGprsTotal(long longGprsTotal) {
        this.longGprsTotal = longGprsTotal;
    }

    public String getGprsUsed() {
        return gprsUsed;
    }

    public void setGprsUsed(String gprsUsed) {
        this.gprsUsed = gprsUsed;
    }

    public long getLongGprsUsed() {
        return longGprsUsed;
    }

    public void setLongGprsUsed(long longGprsUsed) {
        this.longGprsUsed = longGprsUsed;
    }

    public String getPrcName() {
        return prcName;
    }

    public void setPrcName(String prcName) {
        this.prcName = prcName;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getRateType() {
        return rateType;
    }

    public void setRateType(String rateType) {
        this.rateType = rateType;
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }

    public String getNetType() {
        return netType;
    }

    public void setNetType(String netType) {
        this.netType = netType;
    }

    public String getSendType() {
        return sendType;
    }

    public void setSendType(String sendType) {
        this.sendType = sendType;
    }

    public String getShareType() {
        return shareType;
    }

    public void setShareType(String shareType) {
        this.shareType = shareType;
    }

    public String getCarryType() {
        return carryType;
    }

    public void setCarryType(String carryType) {
        this.carryType = carryType;
    }

    public String getCumulateType() {
        return cumulateType;
    }

    public void setCumulateType(String cumulateType) {
        this.cumulateType = cumulateType;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "FreeGprsDetailEntity{" +
                "prcNum=" + prcNum +
                ", prcId='" + prcId + '\'' +
                ", gprsTotal='" + gprsTotal + '\'' +
                ", longGprsTotal=" + longGprsTotal +
                ", gprsUsed='" + gprsUsed + '\'' +
                ", longGprsUsed=" + longGprsUsed +
                ", prcName='" + prcName + '\'' +
                ", productType='" + productType + '\'' +
                ", rateType='" + rateType + '\'' +
                ", useType='" + useType + '\'' +
                ", netType='" + netType + '\'' +
                ", sendType='" + sendType + '\'' +
                ", shareType='" + shareType + '\'' +
                ", carryType='" + carryType + '\'' +
                ", cumulateType='" + cumulateType + '\'' +
                ", beginDate='" + beginDate + '\'' +
                ", endDate='" + endDate + '\'' +
                '}';
    }
}
