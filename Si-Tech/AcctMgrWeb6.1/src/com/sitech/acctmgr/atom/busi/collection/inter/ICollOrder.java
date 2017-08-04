package com.sitech.acctmgr.atom.busi.collection.inter;

import com.sitech.acctmgr.atom.domains.collection.CollEntity;
import com.sitech.acctmgr.atom.domains.collection.CollBillDetailEntity;
import com.sitech.acctmgr.atom.domains.collection.CollBillInfoEntity;
import com.sitech.acctmgr.atom.domains.collection.CollBillStatusGroupEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by wangyla on 2016/12/7.
 */
public interface ICollOrder {
    @SuppressWarnings("unchecked")
    CollBillInfoEntity getCollOrder(long inContractNo, int inBillMonth, String inFlag);

    @SuppressWarnings("unchecked")
    List<CollBillDetailEntity> getCollOrderByDis(
            Map<String, Object> inParam);

    @SuppressWarnings("unchecked")
    List<CollBillStatusGroupEntity> getDisBillGroupByName(
            Map<String, Object> inParam);
}
