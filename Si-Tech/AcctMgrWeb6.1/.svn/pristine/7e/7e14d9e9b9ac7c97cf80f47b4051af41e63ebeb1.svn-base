package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.S8288GrpCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8288GrpCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8288GrpInitInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8288GrpInitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.inter.cct.I8288;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8288Test extends BaseTestCase {

	@Test
	public void testQuery() {
		try {
			I8288 i8288 = (I8288) getBean("8288Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000000\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8288GrpInitInDTO.class);
			S8288GrpInitOutDTO out = (S8288GrpInitOutDTO)i8288.grpInit(in);
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
			I8288 i8288 = (I8288) getBean("8288Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\",\"OP_CODE\":\"8288\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000012\",\"BEGIN_TIME\":\"201508\",\"END_TIME\":\"201908\",\"CREDIT_CODE\":\"C\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8288GrpCfmInDTO.class);
			S8288GrpCfmOutDTO out = (S8288GrpCfmOutDTO)i8288.grpCfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
