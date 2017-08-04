package com.sitech.acctmgr.atom.domains.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 功能：优惠分类展示实体
 * Created by wangyla on 2016/7/18.
 */
public class FreeClassEntity implements Serializable {
	
    @JSONField(name = "FAV_CLASS")
    @ParamDesc(path = "FAV_CLASS", desc = "流量类型分类/地域分类", cons = ConsType.CT001, len = "", memo = "")
    private String favClass;

    @JSONField(name = "FAV_CLASS_NAME")
    @ParamDesc(path = "FAV_CLASS_NAME", desc = "流量分类名称", cons = ConsType.CT001, len = "", memo = "")
    private String favClassName;

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", desc = "总优惠量", cons = ConsType.CT001, len = "", memo = "")
    private String total;

    @JSONField(serialize = false)
    private long longTotal;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", desc = "已使用量", cons = ConsType.CT001, len = "", memo = "")
    private String used;

    @JSONField(serialize = false)
    private long longUsed;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", desc = "剩余量", cons = ConsType.CT001, len = "", memo = "")
    private String remain;

    @JSONField(serialize = false)
    private long longRemain;

    @JSONField(name = "OUT")
    @ParamDesc(path = "OUT", desc = "套餐外使用量", cons = ConsType.CT001, len = "", memo = "GPRS或WLAN时，此参数有值")
    private String out;

    @JSONField(serialize = false)
    private long longOut;

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

    public long getLongTotal() {
        return longTotal;
    }

    public void setLongTotal(long longTotal) {
        this.longTotal = longTotal;
    }

    public long getLongUsed() {
        return longUsed;
    }

    public void setLongUsed(long longUsed) {
        this.longUsed = longUsed;
    }

    public String getRemain() {
        return remain;
    }

    public void setRemain(String remain) {
        this.remain = remain;
    }

    public long getLongRemain() {
        return longRemain;
    }

    public void setLongRemain(long longRemain) {
        this.longRemain = longRemain;
    }

    public String getOut() {
        return out;
    }

    public void setOut(String out) {
        this.out = out;
    }

    public long getLongOut() {
        return longOut;
    }

    public void setLongOut(long longOut) {
        this.longOut = longOut;
    }

    public String getFavClass() {
		return favClass;
	}

	public void setFavClass(String favClass) {
		this.favClass = favClass;
	}

	public String getFavClassName() {
		return favClassName;
	}

	public void setFavClassName(String favClassName) {
		this.favClassName = favClassName;
	}

	@Override
    public String toString() {
        return "FreeClassEntity{" +
                "favClass=" + favClass +
                ", favClassName='" + favClassName + '\'' +
                ", total='" + total + '\'' +
                ", longTotal=" + longTotal +
                ", used='" + used + '\'' +
                ", longUsed=" + longUsed +
                ", remain='" + remain + '\'' +
                ", longRemain=" + longRemain +
                ", out='" + out + '\'' +
                ", longOut=" + longOut +
                '}';
    }
}
