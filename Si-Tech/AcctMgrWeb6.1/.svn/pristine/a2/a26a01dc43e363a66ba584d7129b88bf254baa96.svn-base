package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：优惠分类展示实体
 * Created by wangyla on 2016/7/18.
 */
public class FreeDayInfoEntity implements Serializable {
	
    @JSONField(name = "FAV_DATE")
    @ParamDesc(path = "FAV_DATE", desc = "优惠月日", cons = ConsType.CT001, len = "", memo = "")
    private String favDate;

    @JSONField(name = "PRC_ID")
    @ParamDesc(path = "PRC_ID", desc = "资费ID", cons = ConsType.CT001, len = "", memo = "")
    private String prcId;

    @JSONField(name = "PRC_NAME")
    @ParamDesc(path = "PRC_NAME", desc = "资费名称", cons = ConsType.CT001, len = "", memo = "")
    private String prcName;
    
    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001, len = "20", desc = "应优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001, len = "20", desc = "已优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String used;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", cons = ConsType.CT001, len = "20", desc = "剩余优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String remain;

	public String getFavDate() {
		return favDate;
	}

	public void setFavDate(String favDate) {
		this.favDate = favDate;
	}

	public String getPrcId() {
		return prcId;
	}

	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}

	public String getPrcName() {
		return prcName;
	}

	public void setPrcName(String prcName) {
		this.prcName = prcName;
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

	public String getRemain() {
		return remain;
	}

	public void setRemain(String remain) {
		this.remain = remain;
	}

	@Override
    public String toString() {
        return "FreeDayEntity{" +
                "favDate=" + favDate +
                ", prcId='" + prcId + '\'' +
                ", prcName='" + prcName + '\'' +
                ", total='" + total + '\'' +
                ", used='" + used + '\'' +
                ", remain='" + remain + '\'' +
                '}';
    }
}
