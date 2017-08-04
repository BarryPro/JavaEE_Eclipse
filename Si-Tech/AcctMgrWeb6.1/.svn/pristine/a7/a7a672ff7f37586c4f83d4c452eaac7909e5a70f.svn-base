package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class ExcelListEntity implements Serializable {

    private static final long serialVersionUID = -6573494987087312753L;

    @JSONField(name = "VALUE")
    @ParamDesc(path = "VALUE", cons = ConsType.CT001, type = "string", len = "100", desc = "表格一行数据", memo = "略")
    private String value;


    /**
     * @return the value
     */
    public String getValue() {
        return value;
    }


    /**
     * @param value the value to set
     */
    public void setValue(String value) {
        this.value = value;
    }


    @Override
    public String toString() {
        return "[value:" + value + "]";
    }
}
