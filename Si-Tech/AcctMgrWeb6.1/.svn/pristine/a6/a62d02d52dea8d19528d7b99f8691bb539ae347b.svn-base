package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 用途：统付流量明细实体
 * Created by wangyla on 2016/7/14.
 */
public class FlowDetailEntity implements Serializable {

    @JSONField(name = "SCENE_NAME")
    @ParamDesc(path = "SCENE_NAME", desc = "场景名称", cons = ConsType.CT001, len = "30", memo = "")
    private String sceneName;

    @JSONField(name = "PRODUCT_ID")
    @ParamDesc(path = "PRODUCT_ID", desc = "产品ID", cons = ConsType.CT001, len = "10", memo = "")
    private String productId;

    @JSONField(name = "PRODUCT_NAME")
    @ParamDesc(path = "PRODUCT_NAME", desc = "产品名称", cons = ConsType.CT001, len = "60", memo = "")
    private String productName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", desc = "总优惠量", cons = ConsType.CT001, len = "14", memo = "单位MB")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", desc = "已使用量", cons = ConsType.CT001, len = "14", memo = "单位MB")
    private String used;

    @JSONField(name = "UNIT_NAME")
    @ParamDesc(path = "UNIT_NAME", desc = "计量单位名称", cons = ConsType.CT001, len = "5", memo = "MB")
    private String unitName;

    @JSONField(name = "PERCENT")
    @ParamDesc(path = "PERCENT", desc = "已使用占比", cons = ConsType.CT001, len = "", memo = "")
    private String percent;

    @JSONField(name = "FAV_TYPE")
    @ParamDesc(path = "FAV_TYPE", desc = "优惠类型", cons = ConsType.CT001, len = "4", memo = "")
    private String favType;
    
    @JSONField(name = "FLOW_NAME")
    @ParamDesc(path = "FLOW_NAME", desc = "统付名称", cons = ConsType.CT001, len = "", memo = "")
    private String flowName;
    
    public String getSceneName() {
        return sceneName;
    }

    public void setSceneName(String sceneName) {
        this.sceneName = sceneName;
    }

    public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getPercent() {
        return percent;
    }

    public void setPercent(String percent) {
        this.percent = percent;
    }

    public String getFavType() {
        return favType;
    }

    public void setFavType(String favType) {
        this.favType = favType;
    }

    public String getFlowName() {
		return flowName;
	}

	public void setFlowName(String flowName) {
		this.flowName = flowName;
	}

	@Override
    public String toString() {
        return "FlowDetailEntity{" +
                "sceneName='" + sceneName + '\'' +
                ", productId='" + productId + '\'' +
                ", productName='" + productName + '\'' +
                ", total='" + total + '\'' +
                ", used='" + used + '\'' +
                ", unitName='" + unitName + '\'' +
                ", percent='" + percent + '\'' +
                ", favType='" + favType + '\'' +
                ", flowName='" + flowName + '\'' +
                '}';
    }
}
