package com.sitech.acctmgr.atom.impl.acctmng;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.collection.CollectionConf;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionConfQueryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionConfQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.ICollection;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.acctmng.ICollectionConf;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.List;

/**
 * 区县托收配置信息查询
 * Created by wangyla on 2016/7/8.
 */
@ParamTypes(@ParamType(c = SCollectionConfQueryInDTO.class, m = "query", oc = SCollectionConfQueryOutDTO.class))
public class SCollectionConf extends AcctMgrBaseService implements ICollectionConf {

    private IGroup group;
    private ICollection collection;

    @Override
    public OutDTO query(InDTO inParam){

        SCollectionConfQueryInDTO inDTO = (SCollectionConfQueryInDTO) inParam;

        log.debug("inDto = " + inDTO.getMbean());

        String loginGroupId = inDTO.getGroupId();
        ChngroupRelEntity loginGroupInfo = group.getRegionDistinct(loginGroupId, "3", inDTO.getProvinceId());

        String disGroupId = loginGroupInfo.getParentGroupId();

        List<CollectionConf> confList = collection.getCollConfInfo(disGroupId, null, null);

        if (confList == null || confList.size() == 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8229", "20002"), "该地区不含托收配置信息");
        }

        SCollectionConfQueryOutDTO outDTO = new SCollectionConfQueryOutDTO();
        //outDTO.setConfList(confList);
        outDTO.setEnterCode(confList.get(0).getEnterCode());
        outDTO.setOperType(confList.get(0).getOperType());

        log.debug("outDto=" + outDTO.toJson());

        return outDTO;

    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public ICollection getCollection() {
        return collection;
    }

    public void setCollection(ICollection collection) {
        this.collection = collection;
    }
}
