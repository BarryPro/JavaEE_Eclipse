package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.adj.S8010CfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8010InitInDTO;
import com.sitech.acctmgr.inter.adj.I8010;
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
public class S8010Test extends BaseTestCase {
	
	private I8010 bean = null;

	@Before
	public void before(){
		bean = (I8010) getBean("8010Svc");
	}

	
	@Test
	public void  testInit() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8010\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"18663001484\",\"CONTRACT_NO\":\"220101100000030018\"}}}}");

		InDTO inDTO=parseInDTO(mBean, S8010InitInDTO.class);
		OutDTO resulta=bean.init(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testCfm() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8010\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"18663001484\",\"CONTRACT_NO\":\"220101100000030018\""
				+ ",\"REMARK\":\"补收\",\"BILL_MONTH\":\"201607\","
				+ "\"TOTAL_PAY\":\"100\",\"PAY_DETAIL\":\"0q0q|100#\"}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8010CfmInDTO.class);
		OutDTO resulta=bean.cfm(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
}
