package com.sitech.acctmgr.test.atom.entity;

import com.sitech.acctmgr.atom.busi.collection.inter.ICollOrder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import org.junit.Before;
import org.junit.Test;

/**
 * Created by wangyla on 2016/12/7.
 */
public class CollOrderTest extends BaseTestCase {
    private ICollOrder bean;

    @Before
    public void setUp() throws Exception {
        bean = (ICollOrder) getBean("collOrderEnt");

    }

    @Test
    public void testGetCollOrder() throws Exception {

        long contractNo = 230101100000050051L;
        int yearMonth = 201607;
        String inFlag = null;

        System.out.println(bean.getCollOrder(contractNo, yearMonth, inFlag));
    }
}
