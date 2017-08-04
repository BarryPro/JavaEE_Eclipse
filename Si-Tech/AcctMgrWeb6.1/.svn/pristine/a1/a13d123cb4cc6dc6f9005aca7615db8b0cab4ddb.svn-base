package com.sitech.acctmgr.test.atom.impl.pay;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.S8000InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8000InitOutDTO;
import com.sitech.acctmgr.inter.pay.I8000Ao;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8000Test extends BaseTestCase{

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
	 * Test method for {@link com.sitech.acctmgr.atom.impl.pay.S8000#init(com.sitech.jcfx.dt.in.InDTO)}.
	 */
	@Test
	public void testInit() {

			I8000Ao i8000 = (I8000Ao) getBean("8000AoSvc");

		try {
			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"A1\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\": \"dd1124\",	\"LOGIN_PASSWORD\":\"xxxxxxxx\" },\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"CONTRACT_NO\":\"\",\"PAY_PATH\": \"11\"}}}}");
			
			InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			S8000InitOutDTO out = (S8000InitOutDTO)i8000.init(in);
			String result = out.toJson();
			System.out.println("result = " + result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.impl.pay.S8000#cfm(com.sitech.jcfx.dt.in.InDTO)}.
	 */
	@Test
	public void testCfm() {
		fail("Not yet implemented");
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.impl.pay.S8000#cfmDiscount(com.sitech.jcfx.dt.in.InDTO)}.
	 */
	@Test
	public void testCfmDiscount() {
		fail("Not yet implemented");
	}

}
