package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.collection.CollectionDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2016/7/5.
 */
public class SCollectionOrderQueryOutDTO extends CommonOutDTO {
    private static final long serialVersionUID = -1L;

    @JSONField(name="COLL_LIST")
    @ParamDesc(path="COLL_LIST",cons= ConsType.CT001,len="",desc="托收单打印列表",type="complex",memo="略")
    List<CollectionDispEntity> outList = new ArrayList<CollectionDispEntity>();

    @JSONField(name="COUNT")
    @ParamDesc(path="COUNT",cons=ConsType.CT001,len="",desc="帐户个数",type="int",memo="略")
    int count = 0;

    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("outList"), outList);
        result.setRoot(getPathByProperName("count"), count);
        return result;
    }

    public List<CollectionDispEntity> getOutList() {
        return outList;
    }

    public void setOutList(List<CollectionDispEntity> outList) {
        this.outList = outList;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
