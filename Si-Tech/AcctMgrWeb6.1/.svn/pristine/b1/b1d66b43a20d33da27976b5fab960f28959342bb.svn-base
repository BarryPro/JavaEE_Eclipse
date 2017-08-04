package com.sitech.acctmgr.test.atom.busi.pay;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.busi.pay.WriteOffer;
import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
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
public class WriteOfferTest extends BaseTestCase{

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
	 * Test method for {@link com.sitech.acctmgr.atom.busi.pay.WriteOffer#getOffLineConPre(java.lang.Long, java.lang.Double, com.sitech.acctmgr.atom.domains.bill.UnbillEntity)}.
	 */
	@Test
	public void testGetOffLineConPre() {
		
		IWriteOffer writeOffer = (IWriteOffer) getBean("writeOfferEnt");
		
		long contractNo = 230800003005413006L;
		UnbillEntity unbill = new UnbillEntity();
		OutFeeData outFee = null;
		try {
			
			outFee = writeOffer.getOffLineConPre(contractNo, 1.0, unbill);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		System.out.println("result = " + outFee);
		
	}

}
