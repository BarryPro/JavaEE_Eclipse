package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8124InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8124InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitOutDTO;
import com.sitech.acctmgr.inter.query.I8124;
import com.sitech.acctmgr.inter.query.I8155;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8124Test extends BaseTestCase{

	@Test
	public void testQuery() {
		try {
			I8124 i8124 = (I8124) getBean("8124Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_TIME\":\"201508\",\"END_TIME\":\"201908\",\"REFUND_FLAG\":\"1\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8124InitInDTO.class);
			S8124InitOutDTO out = (S8124InitOutDTO)i8124.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
