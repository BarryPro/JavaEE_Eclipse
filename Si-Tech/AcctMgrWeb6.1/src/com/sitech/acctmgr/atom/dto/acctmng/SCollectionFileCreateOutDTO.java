package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/7.
 */
public class SCollectionFileCreateOutDTO extends CommonOutDTO{

    @JSONField(name = "FILE_FULL_NAME")
    @ParamDesc(path = "FILE_FULL_NAME", cons = ConsType.PLUS, type = "string", len = "", desc = "托收文件生成全路径名称", memo = "略")
    private String fileFullName;

    @Override
    public MBean encode() {
        MBean result = super.encode();

        result.setRoot(getPathByProperName("fileFullName"), fileFullName);

        return result;
    }

    public String getFileName() {
        return fileFullName;
    }

    public void setFileName(String fileFullName) {
        this.fileFullName = fileFullName;
    }
}
