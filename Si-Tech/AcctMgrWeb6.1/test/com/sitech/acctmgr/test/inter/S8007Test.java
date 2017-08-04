package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.S8007CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8007InitInDTO;
import com.sitech.acctmgr.inter.pay.I8007;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class S8007Test extends BaseTestCase {

	private I8007 bean = null;

	@Before
	public void before(){
		bean = (I8007) getBean("8007Svc");
	}

	
	@Test
	public void  testInit() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8007\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000040014\",\"ID_NO\":\"220121000000008271\",\"BACK_TYPE\":\"1\",\"CUST_ID\":\"220101100000050016\",\"PAY_SN\":\"10000000100250\",\"PAY_TIME\":\"20160802115526\"}}}}");

		InDTO inDTO=parseInDTO(mBean, S8007InitInDTO.class);
		OutDTO result=bean.init(inDTO);

		System.out.println("----->"+result.toJson());
	}
	
	@Test
	public void  testCfm() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8007\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"ID_NO\":\"220121000000008271\",\"PAY_TIME\":\"20160804140941\",\"PAY_SN\":\"10000000100268\",\"PAY_TYPE\":\"0\",\"BACK_TYPE\":\"1\",\"PAY_NOTE\":\"\"}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8007CfmInDTO.class);
		OutDTO result=bean.cfm(inDTO);

		System.out.println("----->"+result.toJson());
	}
	
}
