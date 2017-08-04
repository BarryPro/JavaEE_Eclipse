package com.sitech.acctmgr.test.atom.entity;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.collection.CollectionDispEntity;
import com.sitech.acctmgr.atom.entity.inter.ICollection;
import com.sitech.acctmgr.test.junit.BaseTestCase;

/**
 * Created by wangyla on 2016/7/6.
 */
public class CollectionTest extends BaseTestCase {
    private ICollection collection;

    @Before
    public void setUp() throws Exception {
        collection = (ICollection) getBean("collectionEnt");

    }

    @Test
    public void testGetCollectionOrderList() throws Exception {

        String disGroupId = "14";
        int yearMonth = 201306;
        String begBank = "a0001";
        String endBank = "a0005";
        int begPrintNo = 0;
        int endPrintNo = 9999;
        String provinceId = "220000";

        List<CollectionDispEntity> result = collection.getCollectionOrderList(disGroupId, yearMonth, begBank, endBank, begPrintNo, endPrintNo, provinceId,false);
        System.out.println("result = " + result.toString());
    }
}