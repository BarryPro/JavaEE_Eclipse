package com.sitech.acctmgr.test.inter;

import com.sitech.acctmgr.atom.dto.pay.S8295InitInDTO;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.adj.S8010CfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8010InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8295CfmInDTO;
import com.sitech.acctmgr.inter.adj.I8010;
import com.sitech.acctmgr.inter.pay.I8295;
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
public class S8295Test extends BaseTestCase {
	
	private I8295 bean = null;

	@Before
	public void before(){
		bean = (I8295) getBean("8295Svc");
	}

	 
	@Test
	public void  testCfm() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"RELPATH\":\"/BOSS/201608/12/jiangxl/8295Trans.txt\",\"REMARK\":\"划拨\""
				+ ",\"REMARK\":\"补收\",\"BILL_MONTH\":\"201607\","
				+ "\"GROUP_CONTRACT_NO\":\"220101100000030017\"}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8295CfmInDTO.class);
		OutDTO resulta=bean.cfm(inDTO);

		System.out.println("----->"+resulta.toJson());
	}

	@Test
	public void testInit() throws Exception {
		MBean inParam=new MBean("{\n" +
				"    \"ROOT\": {\n" +
				"        \"HEADER\": {\n" +
				"            \"DB_ID\": \"\",\n" +
				"            \"ENV_ID\": \"\",\n" +
				"            \"ROUTING\": {\n" +
				"                \"ROUTE_KEY\": \"\",\n" +
				"                \"ROUTE_VALUE\": \"\"\n" +
				"            },\n" +
				"            \"PROVINCE_GROUP\": \"HLJ\",\n" +
				"            \"POOL_ID\": \"11\"\n" +
				"        },\n" +
				"        \"BODY\": {\n" +
				"            \"OPR_INFO\": {\n" +
				"                \"OP_CODE\": \"8295\",\n" +
				"                \"GROUP_ID\": \"13436\",\n" +
				"                \"LOGIN_NO\": \"aan70W\"\n" +
				"            },\n" +
				"            \"BUSI_INFO\": {\n" +
				"                \"ID_ICCID\": \"\",\n" +
				"                \"CUST_ID\": \"230740002900000463\",\n" +
				"                \"UNIT_ID\": \"\"\n" +
				"            }\n" +
				"        }\n" +
				"    }\n" +
				"}");

		InDTO inDTO=parseInDTO(inParam, S8295InitInDTO.class);
		OutDTO resulta=bean.init(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
}
