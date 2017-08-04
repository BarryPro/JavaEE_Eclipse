package com.sitech.acctmgr.atom.dto.free;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.free.CarryOverGPRSEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/7/13.
 */
public class SFreeCarryOverQueryOutDTO extends CommonOutDTO {

    @ParamDesc(path = "GPRS_NAME_LIST", desc = "GPRS名称列表", cons = ConsType.QUES, type= "complex", len = "", memo = "List<String>")
    private List<String> gprsNameList;

    @ParamDesc(path = "CARRY_INFO_LIST", desc = "GPRS结转信息列表", cons = ConsType.QUES, type= "complex", len = "", memo = "List列表")
    private List<CarryOverGPRSEntity> carryInfoList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("gprsNameList"), gprsNameList);
        result.setRoot(getPathByProperName("carryInfoList"), carryInfoList);

        return result;
    }

    public List<String> getGprsNameList() {
        return gprsNameList;
    }

    public void setGprsNameList(List<String> gprsNameList) {
        this.gprsNameList = gprsNameList;
    }

    public List<CarryOverGPRSEntity> getCarryInfoList() {
        return carryInfoList;
    }

    public void setCarryInfoList(List<CarryOverGPRSEntity> carryInfoList) {
        this.carryInfoList = carryInfoList;
    }
}
