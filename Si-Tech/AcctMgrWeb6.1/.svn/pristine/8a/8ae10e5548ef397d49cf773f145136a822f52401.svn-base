package com.sitech.acctmgr.test.atom.busi.query;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.busi.query.inter.IOweBill;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.test.junit.BaseTestCase;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class OweBillTest  extends BaseTestCase {

	/**
	 * 名称：
	 * @param 
	 * @return 
	 * @throws 
	 */
	@Before
	public void setUp() throws Exception {
	}

	/**
	 * 名称：
	 * @param 
	 * @return 
	 * @throws 
	 */
	@After
	public void tearDown() throws Exception {
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.busi.query.OweBill#getHisOweFeeInfo(long)}.
	 */
	@Test
	public void testGetHisOweFeeInfo() {
		
		IOweBill oweBill = (IOweBill) getBean("oweBillEnt");
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		long contractNo = 220470200034905702L;
		Map<String, Object> outMap = null;
		try {
			outMap = oweBill.getHisOweFeeInfo(contractNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + outMap);
		
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.busi.query.OweBill#getOweDetailList(long)}.
	 */
	@Test
	public void testGetOweDetailList() {

		IOweBill oweBill = (IOweBill) getBean("oweBillEnt");
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		long contractNo = 220470200034905702L;
		List<Map<String, Object>> outList = null;
		try {
			outList = oweBill.getOweDetailList(contractNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + outList);
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.busi.query.OweBill#getOweFeeInfo(long)}.
	 */
	@Test
	public void testGetOweFeeInfoLong() {
		fail("Not yet implemented");
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.busi.query.OweBill#getOweFeeInfo(long, long)}.
	 */
	@Test
	public void testGetOweFeeInfoLongLong() {
		fail("Not yet implemented");
	}

}
