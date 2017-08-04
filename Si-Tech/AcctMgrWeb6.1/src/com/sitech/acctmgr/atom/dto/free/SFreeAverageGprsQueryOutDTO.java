package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.FreeDetailEntity;
import com.sitech.acctmgr.atom.domains.free.FreeUseInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/18.
 */
public class SFreeAverageGprsQueryOutDTO extends CommonOutDTO {

    @JSONField(name = "AVERAGE_GPRS")
    @ParamDesc(path = "AVERAGE_GPRS", cons = ConsType.CT001, len = "", type = "string", desc = "流量平均用量", memo = "")
    private String averageGprs;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("averageGprs"), averageGprs);
        return result;
    }

	public String getAverageGprs() {
		return averageGprs;
	}

	public void setAverageGprs(String averageGprs) {
		this.averageGprs = averageGprs;
	}

}
