package com.sitech.acctmgr.test.atom.entity;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.test.junit.BaseTestCase;

/**
 * Created by wangyla on 2016/7/4.
 */
public class FreeDisplayerTest extends BaseTestCase {
    private IFreeDisplayer freeDisplayer;

    @Before
    public void setUp(){
        freeDisplayer = (IFreeDisplayer)getBean("freeDisplayerEnt");
    }

    @Test
    public void testGetFreeDetailList() throws Exception {

        String phoneNo = "18246162371";//13895798069
        int queryYM = 201610;
        String busiCode = "0";
        System.out.println(freeDisplayer.getFreeDetailList(phoneNo, queryYM, busiCode));
    }

    @Test
    public void testGetFreeDetailList2() throws Exception {

        String phoneNo = "13895798069";//13895798069
        int queryYM = 201608;
        String busiCode = "W";
        String queryType = "a";
        System.out.println(freeDisplayer.getFreeDetailList(phoneNo, queryYM, busiCode, queryType));
    }

    @Test
    public void testGetFreeTotalInfo(){
        String phoneNo = "18246162371";
        int queryYM = 201608;
        String busiCode = "0";
        System.out.println(freeDisplayer.getFreeTotalInfo(phoneNo, queryYM, busiCode));
    }
}