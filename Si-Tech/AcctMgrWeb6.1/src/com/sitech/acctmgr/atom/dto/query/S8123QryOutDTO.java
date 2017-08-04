package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.query.FreeDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author
 * @version 1.0
 */

@SuppressWarnings("serial")
public class S8123QryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "FREE_INFO", cons = ConsType.QUES, len = "", type = "complex", desc = "免费分钟数列表", memo = "略")
    private List<FreeDispEntity> freeList = null;

    @Override
    public MBean encode() {
        MBean bean = new MBean();
        bean.setRoot(getPathByProperName("freeList"), freeList);

        return bean;
    }

    public List<FreeDispEntity> getFreeList() {
        if (null == freeList) {
            freeList = new ArrayList<FreeDispEntity>();
        }
        return freeList;
    }

    public void setFreeList(List<FreeDispEntity> freeList) {
        this.freeList = freeList;
    }

}
