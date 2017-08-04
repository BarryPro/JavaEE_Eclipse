package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8291CfmInDTO;
import com.sitech.acctmgr.atom.dto.query.S8291CfmOutDTO;
import com.sitech.acctmgr.inter.query.I8291;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8291Test extends BaseTestCase{

	@Test
	public void testCfm() {
		try {
			I8291 i8291 = (I8291) getBean("8291Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8288\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663001478\",\"BEGIN_TIME\":\"20150801\",\"END_TIME\":\"20190801\",\"DETAIL_TYPE\":\"3000\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8291CfmInDTO.class);
			S8291CfmOutDTO out = (S8291CfmOutDTO)i8291.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
