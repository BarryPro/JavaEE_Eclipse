package com.sitech.acctmgr.test.atom.entity;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.test.junit.BaseTestCase;

public class BillAccountTest extends BaseTestCase {
	private IBillAccount billAccount = null;

	@Before
	public void setUp() throws Exception {
		billAccount = (IBillAccount)getBean("billAccountEnt");
	}

	@After
	public void tearDown() throws Exception {
		
	}
	
	@Test
	public void testGetPriceName() {
		System.out.println(billAccount.getPriceInfo("M006"));
	}
	
	@Test
	public void testGetPriceInfos() {
		System.out.println(billAccount.getPriceInfo("Mz71", "1", "", "1,2"));
	}
	
	@Test
	public void testGetPrcDetailList(){
		System.out.println(billAccount.getPrcDetailList("M005073", "1", "2307"));
	}
	
	@Test
	public void testGetModeList(){
		System.out.println(billAccount.getRateCode("M052631", "0", "2301"));
	}

	@Test
	public void testIsSharePrcId() {
		System.out.println(billAccount.isSharePrcId("M052631", "2303"));
	}
	
}
