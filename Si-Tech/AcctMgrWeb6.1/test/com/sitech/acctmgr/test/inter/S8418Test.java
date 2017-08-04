package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8418InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8418InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitOutDTO;
import com.sitech.acctmgr.inter.billAccount.I8504;
import com.sitech.acctmgr.inter.query.I8418;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8418Test extends BaseTestCase{
	@Test
	public void testInit() {
		try {
			I8418 i8418 = (I8418) getBean("8418Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PAY_NAME\":\"\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8418InitInDTO.class);
			S8418InitOutDTO out = (S8418InitOutDTO)i8418.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
