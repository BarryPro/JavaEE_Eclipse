package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S8120QryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8120QryOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8124InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8124InitOutDTO;
import com.sitech.acctmgr.inter.billAccount.I8120;
import com.sitech.acctmgr.inter.query.I8124;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8120Test extends BaseTestCase{

	@Test
	public void testQuery() {
		try {
			I8120 i8120 = (I8120) getBean("8120Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"OP_TYPE\":\"0\",\"MSC_ID\":\"1111\",\"END_TIME\":\"20190801\",\"BEGIN_TIME\":\"20150801\"}}}}");
			InDTO in = parseInDTO(inMBean, S8120QryInDTO.class);
			S8120QryOutDTO out = (S8120QryOutDTO)i8120.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
