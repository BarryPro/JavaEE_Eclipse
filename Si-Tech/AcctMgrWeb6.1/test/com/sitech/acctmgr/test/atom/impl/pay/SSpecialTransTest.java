package com.sitech.acctmgr.test.atom.impl.pay;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.SpecialTransBnCfmInDTO;
import com.sitech.acctmgr.inter.pay.ISpecialTrans;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SSpecialTransTest extends BaseTestCase{

	private static ISpecialTrans specialTrans;
	
	@Before
	public void setUp() throws Exception {
		
		if(specialTrans==null){
			specialTrans = (ISpecialTrans)getBean("specialTransSvc"); 
		}
	}
	
	@Test
	public void testbnCfm(){
		
		MBean inParam = new MBean("{\"ROOT\":{\"HEADER\":{\"ROUTING\":{\"ROUTE_KEY\":\"11\",\"ROUTE_VALUE\":\"230380002013345850\"},\"DB_ID\":\"B1\",\"TRACE_ID\":\"11*20170424173353*null*ceaaa3*854525\",\"KEEP_LIVE\":\"10.109.224.46\",\"CHANNEL_ID\":\"11\",\"PARENT_CALL_ID\":\"8E01605048D8379FD3F9266B38ED514E\",\"POOL_ID\":\"1\"},\"BODY\":{\"OPR_INFO\":{\"OP_CODE\":\"1090\",\"OP_TIME\":\"20170424174436\",\"LOGIN_NO\":\"ceaaa3\",\"ACTION_ID\":\"10900\",\"ORDER_LINE_ID\":\"L17042400001903\"},\"BUSI_INFO\":{\"OUT_PHONE_NO\":\"13946333318\",\"PAY_PATH\":\"11\",\"BUSI_CODE\":\"ZHZZ\",\"EFFECT_MONTH\":\"12\",\"BEGIN_DATE\":\"20170501000000\",\"OP_NOTE\":\"包年转款费用订单行\",\"OUT_CONTRACT_NO\":\"230380002013345850\",\"YEAR_FEE\":\"6000\",\"IN_CONTRACT_NO\":\"230300001000040094\",\"MONTH_FLAG\":\"0\",\"PHONE_NO\":\"13946333318\",\"PAY_FEE\":\"6000\",\"PAY_TYPE\":\"EA\",\"IN_PHONE_NO\":\"13946333318\",\"IS_PRINT\":\"N\",\"OP_TYPE\":\"BN\",\"PAY_METHOD\":\"71\",\"CONTRACT_NO\":\"230301100000980000\"}}}}");
		
		log.info("inParam: " + inParam.toString());
		try {
			InDTO inDto = parseInDTO(inParam, SpecialTransBnCfmInDTO.class);
			OutDTO outDTO = specialTrans.bnCfm(inDto);
		} catch (Exception e) {

			e.printStackTrace();
			e.getMessage();
		}
		
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

	@Test
	public void test() {
		fail("Not yet implemented");
	}

}
