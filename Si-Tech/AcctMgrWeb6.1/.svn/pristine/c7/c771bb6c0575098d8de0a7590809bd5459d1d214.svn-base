package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.S8014CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8014InitInDTO;
import com.sitech.acctmgr.inter.pay.I8014;
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
public class S8014Test extends BaseTestCase {
	
	private I8014 bean = null;

	@Before
	public void before(){
		bean = (I8014) getBean("8014Svc");
	}

	
	@Test
	public void  testInit() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aan70W\",\"GROUP_ID\":\"13436\",\"OP_CODE\":\"8014\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"18663001484\",\"CONTRACT_NO\":\"220101100000030018\",\"ID_NO\":\"220101000000008024\""
				+ ",\"IF_ONNET\":\"1\",\"OP_TYPE\":\"Account\",\"CONTRACT_PASS\":\"665427\"}}}}");

		InDTO inDTO=parseInDTO(mBean, S8014InitInDTO.class);
		OutDTO resulta=bean.init(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testCfm() throws Exception{
		MBean inParam=new MBean("{\n" +
				"    \"ROOT\": {\n" +
				"        \"BODY\": {\n" +
				"            \"BUSI_INFO\": {\n" +
				"                \"IF_ONNET\": \"1\",\n" +
				"                \"IN_CONTRACT_NO\": \"230300001000040094\",\n" +
				"                \"IN_PHONE_NO\": \"13904538536\",\n" +
				"                \"ONE_TRANS_FEE\": \"100\",\n" +
				"                \"OP_NOTE\": \"\",\n" +
				"                \"OP_TYPE\": \"TransAccountEnt\",\n" +
				"                \"OUT_CONTRACT_NO\": \"230300002000000004\",\n" +
				"                \"OUT_PHONE_NO\": \"13504530004\",\n" +
				"                \"PAY_METHOD\": \"A\",\n" +
				"                \"PAY_PATH\": \"11\",\n" +
				"                \"REASON\": \"\",\n" +
				"                \"TRANS_COUNT\": \"1\",\n" +
				"                \"TRANS_FEE\": \"100\"\n" +
				"            },\n" +
				"            \"OPR_INFO\": {\n" +
				"                \"GROUP_ID\": \"10477\",\n" +
				"                \"LOGIN_NO\": \"ceaaa3\",\n" +
				"                \"OP_CODE\": \"8014\",\n" +
				"                \"PROVINCE_ID\": \"230000\"\n" +
				"            }\n" +
				"        },\n" +
				"        \"HEADER\": {\n" +
				"            \"CHANNEL_ID\": \"11\",\n" +
				"            \"DB_ID\": \"B1\",\n" +
				"            \"ENV_ID\": \"\",\n" +
				"            \"KEEP_LIVE\": \"10.109.224.91\",\n" +
				"            \"PARENT_CALL_ID\": \"F83EF5F16D54FBF562FC6D0FF1CEBE5C\",\n" +
				"            \"POOL_ID\": \"2\",\n" +
				"            \"ROUTING\": {\n" +
				"                \"ROUTE_KEY\": \"12\",\n" +
				"                \"ROUTE_VALUE\": \"230300002000000004\"\n" +
				"            },\n" +
				"            \"TRACE_ID\": \"11*20170424102823*null*ceaaa3*390684\"\n" +
				"        }\n" +
				"    }\n" +
				"}");

		InDTO inDTO=parseInDTO(inParam, S8014CfmInDTO.class);
		OutDTO resulta=bean.cfm(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
}
