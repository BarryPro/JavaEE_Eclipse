package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.S8258CfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8258CfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8258NonStopOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8258QryInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8258QryOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitOutDTO;
import com.sitech.acctmgr.inter.cct.I8258;
import com.sitech.acctmgr.inter.query.I8155;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8258Test extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			I8258 i8258 = (I8258) getBean("8258Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000013\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8258QryInDTO.class);
			S8258QryOutDTO out = (S8258QryOutDTO)i8258.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testCfm() {
		try {
			I8258 i8258 = (I8258) getBean("8258Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\",\"OP_CODE\":\"8258\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000013\",\"ID_NO\":\"220171000000007738\",\"CONTRACT_NO\":\"220101100000010000\",\"RED_TYPE\":\"1\",\"MONTH_LENGTH\":\"1\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8258CfmInDTO.class);
			S8258CfmOutDTO out = (S8258CfmOutDTO)i8258.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testNonStop() {
		try {
			I8258 i8258 = (I8258) getBean("8258Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\",\"OP_CODE\":\"8258\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000013\",\"ID_NO\":\"220171000000007738\",\"CONTRACT_NO\":\"220101100000010000\",\"RED_TYPE\":\"1\",\"MONTH_LENGTH\":\"1\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8258QryInDTO.class);
			S8258NonStopOutDTO out = (S8258NonStopOutDTO)i8258.nonStopQry(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
