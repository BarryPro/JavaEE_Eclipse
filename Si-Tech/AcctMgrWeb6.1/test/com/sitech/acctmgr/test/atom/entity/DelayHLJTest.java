package com.sitech.acctmgr.test.atom.entity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IDelay;
import com.sitech.acctmgr.test.junit.BaseTestCase;

public class DelayHLJTest extends BaseTestCase {

    private IDelay delay = null;

    @Before
    public void before() {
    	delay = (IDelay)getBean("delayEnt");
    }
    
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetDelayFee() {
		
		long delayFee = 0;
		try {
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("BILL_BEGIN", "20150801");
			inMap.put("OWE_FEE", 100);
			inMap.put("DELAY_BEGIN", 0);
			inMap.put("DELAY_RATE", ".003");
			inMap.put("BILL_CYCLE", "201508");
			inMap.put("TOTAL_DATE", "20161206");
			delayFee = delay.getDelayFee(inMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("result = " + delayFee);
		
	}

}
