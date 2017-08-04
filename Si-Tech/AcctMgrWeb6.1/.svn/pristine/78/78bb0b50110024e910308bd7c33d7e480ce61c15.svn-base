package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S8293InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293OutDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitOutDTO;
import com.sitech.acctmgr.inter.acctmng.I8293;
import com.sitech.acctmgr.inter.billAccount.I8504;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8504Test extends BaseTestCase{
	
	@Test
	public void testInit() {
		try {
			I8504 i8504 = (I8504) getBean("8504Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"FLAG_CODE\":\"00g40w\",\"QUERY_TYPE\":\"2\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8504InitInDTO.class);
			S8504InitOutDTO out = (S8504InitOutDTO)i8504.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
