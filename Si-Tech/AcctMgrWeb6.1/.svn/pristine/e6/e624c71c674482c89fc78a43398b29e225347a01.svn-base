package com.sitech.acctmgr.test.atom.entity;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.test.junit.BaseTestCase;

public class AccountTest extends BaseTestCase {

    private IAccount account = null;

    @Before
    public void before() {
        account = (IAccount)getBean("accountEnt");
    }

    
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetConInfo() {
		
		IAccount account = (IAccount) getBean("accountEnt");
		
		ContractInfoEntity out = null;
		
		long inContractNo = 220101100000040035L;
		try {
			out = account.getConInfo(inContractNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + out.toString());
		
	}

    @Test
    public void testGetConList1() throws Exception {
        long idNo = 220171000000007738L;
        int yearMonth = 201604;
        List<ContractEntity> result = account.getConList(idNo, yearMonth);
        System.out.println(result.toString());

    }

    @Test
    public void testIsGrpCon() throws Exception {
        long conNo = 220101100000010000L;
        System.out.println(account.isGrpCon(conNo));
    }
}
