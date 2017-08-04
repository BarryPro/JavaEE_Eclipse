package com.sitech.acctmgr.atom.dto.free;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeClassEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/21.
 */
public class SFreeClassQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "TOTAL")
    @ParamDesc(path = "TOTAL", cons = ConsType.CT001, len = "20", desc = "应优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String total;

    @JSONField(name = "USED")
    @ParamDesc(path = "USED", cons = ConsType.CT001, len = "20", desc = "已优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String used;

    @JSONField(name = "REMAIN")
    @ParamDesc(path = "REMAIN", cons = ConsType.CT001, len = "20", desc = "剩余优惠总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String remain;
    
    @JSONField(name = "OUT")
    @ParamDesc(path = "OUT", cons = ConsType.CT001, len = "20", desc = "套餐外流量总量", type = "String", memo = "单位：MB 或 GB+MB")
    private String out;

    @JSONField(name = "FREE_INFO")
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "优惠信息", memo = "列表；套餐类别以及类别名称，优惠量")
    private List<FreeClassEntity> freeInfo;


    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("total"), total);
        result.setRoot(getPathByProperName("used"), used);
        result.setRoot(getPathByProperName("remain"), remain);
        result.setRoot(getPathByProperName("out"), out);
        result.setRoot(getPathByProperName("freeInfo"), freeInfo);
        return result;
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

	public String getOut() {
		return out;
	}

	public void setOut(String out) {
		this.out = out;
	}

	public List<FreeClassEntity> getFreeInfo() {
		return freeInfo;
	}

	public void setFreeInfo(List<FreeClassEntity> freeInfo) {
		this.freeInfo = freeInfo;
	}

}
