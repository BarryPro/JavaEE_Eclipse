package com.sitech.acctmgr.test.atom.entity;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.test.junit.BaseTestCase;

/**
 * Created by wangyla on 2016/7/6.
 */
public class BaseTest extends BaseTestCase {
    private IBase bean;

    @Before
    public void setUp() throws Exception {
        bean = (IBase) getBean("baseEnt");
    }

    @Test
    public void testGetBankInfo() throws Exception {

        String disGroupId = "14";
        String provinceId = "220000";
        String blurBankCode = "";
        String blurBankName = "光大";
        System.out.println(bean.getBankInfo(disGroupId, provinceId, blurBankCode, blurBankName));
    }
}