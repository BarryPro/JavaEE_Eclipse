package com.sitech.acctmgr.test.atom.entity;

import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by wangyla on 2016/5/15.
 */
public class CreditTest extends BaseTestCase {
    private ICredit credit;
    @Before
    public void before() {
        credit = (ICredit) getBean("creditEnt");
    }

    @Test
    public void testGetCreditInfo() throws Exception {
        long idNo = 220171000000007738L;
//        long idNo = 220171000000007739L;
        String regionCode = "2201";
        try {
            //System.out.println(credit.getCreditInfo(idNo, regionCode));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
    }

    @Test
    public void testGetCreditInfoByIdNo() throws Exception {

    }

    @Test
    public void testGetCreditName() throws Exception {

    }
}