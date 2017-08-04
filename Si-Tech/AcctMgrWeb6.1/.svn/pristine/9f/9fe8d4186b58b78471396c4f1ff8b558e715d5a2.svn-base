package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S8510InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8510OutDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitOutDTO;
import com.sitech.acctmgr.inter.billAccount.I8504;
import com.sitech.acctmgr.inter.billAccount.I8510;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8510Test extends BaseTestCase{
	
	@Test
	public void testCfm() {
		try {
			I8510 i8510 = (I8510) getBean("8510Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161254\",\"OP_TYPE\":\"1\",\"FD_TYPE\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8510InDTO.class);
			S8510OutDTO out = (S8510OutDTO)i8510.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

