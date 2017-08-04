package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.TrafficBillEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/14.
 */
public class SGPRSBillQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path="TOTAL_SHOULD", cons= ConsType.CT001, type="long", len="14", desc="套餐内上网总应收费用(gprs+wlan)", memo="单位：分")
    private long totalShould;

    @ParamDesc(path="TOTAL_FAVOUR", cons= ConsType.CT001, type="long", len="14", desc="套餐内上网总优惠费用", memo="单位：分")
    private long totalFavour;

    @ParamDesc(path="TOTAL_FEE", cons= ConsType.CT001, type="long", len="14", desc="套餐内上网总实收费用", memo="单位：分")
    private long totalFee;

    @ParamDesc(path="OUT_GPRS_TOTAL", cons= ConsType.CT001, type="String", len="14", desc="套餐外总流量", memo="只含GPRS，不包括wlan")
    private String outGprsTotal;

    @ParamDesc(path="UNIT_NAME", cons= ConsType.CT001, type="String", len="10", desc="套餐外流量单位", memo="")
    private String unitName;

    @ParamDesc(path="OUT_GPRS_TOTAL_FEE", cons= ConsType.CT001, type="long", len="14", desc="套餐外上网总实收费用", memo="单位：分")
    private long outGprsTotalFee;

    @ParamDesc(path="TIPS", cons=ConsType.CT001, type="string", len="256", desc="温馨提示", memo="")
    private String tips;
    
    @ParamDesc(path="ADDED_TIPS", cons=ConsType.CT001, type="string", len="256", desc="附加提醒", memo="")
    private String addedTips;
    
    @ParamDesc(path="PRC_SCHEMA_INFO", cons=ConsType.CT001, type="string", len="256", desc="资费推荐信息", memo="")
    private String prcSchemeInfo;
    
    @ParamDesc(path="PRC_ID_NEW", cons=ConsType.CT001, type="string", len="256", desc="资费代码", memo="")
    private String prcId;

    @ParamDesc(path="MEAL_BILL_LIST", cons=ConsType.STAR, type="complex", len="", desc="套餐内流量信息", memo="列表List")
    private List<TrafficBillEntity> mealBillList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("totalShould"), totalShould);
        result.setRoot(getPathByProperName("totalFavour"), totalFavour);
        result.setRoot(getPathByProperName("totalFee"), totalFee);
        result.setRoot(getPathByProperName("outGprsTotal"), outGprsTotal);
        result.setRoot(getPathByProperName("unitName"), unitName);
        result.setRoot(getPathByProperName("outGprsTotalFee"), outGprsTotalFee);
        result.setRoot(getPathByProperName("tips"), tips);
        result.setRoot(getPathByProperName("addedTips"), addedTips);
        result.setRoot(getPathByProperName("prcId"), prcId);
        result.setRoot(getPathByProperName("prcSchemeInfo"), prcSchemeInfo);
        result.setRoot(getPathByProperName("mealBillList"), mealBillList);
        return result;
    }

    public long getTotalShould() {
        return totalShould;
    }

    public void setTotalShould(long totalShould) {
        this.totalShould = totalShould;
    }

    public long getTotalFavour() {
        return totalFavour;
    }

    public void setTotalFavour(long totalFavour) {
        this.totalFavour = totalFavour;
    }

    public long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(long totalFee) {
        this.totalFee = totalFee;
    }

    public String getOutGprsTotal() {
        return outGprsTotal;
    }

    public void setOutGprsTotal(String outGprsTotal) {
        this.outGprsTotal = outGprsTotal;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public long getOutGprsTotalFee() {
        return outGprsTotalFee;
    }

    public void setOutGprsTotalFee(long outGprsTotalFee) {
        this.outGprsTotalFee = outGprsTotalFee;
    }

    public String getTips() {
		return tips;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

	public String getAddedTips() {
		return addedTips;
	}

	public void setAddedTips(String addedTips) {
		this.addedTips = addedTips;
	}

	public String getPrcSchemeInfo() {
		return prcSchemeInfo;
	}

	public void setPrcSchemeInfo(String prcSchemeInfo) {
		this.prcSchemeInfo = prcSchemeInfo;
	}

	public String getPrcId() {
		return prcId;
	}

	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}

	public List<TrafficBillEntity> getMealBillList() {
        return mealBillList;
    }

    public void setMealBillList(List<TrafficBillEntity> mealBillList) {
        this.mealBillList = mealBillList;
    }
}
