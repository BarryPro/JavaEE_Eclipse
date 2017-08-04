package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S3104InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S3104OutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8120QryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8120QryOutDTO;
import com.sitech.acctmgr.inter.billAccount.I3104;
import com.sitech.acctmgr.inter.billAccount.I8120;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S3104Test extends BaseTestCase{

	@Test
	public void testQuery() {
		try {
			I3104 i3104 = (I3104) getBean("3104Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\"}}}}");
			InDTO in = parseInDTO(inMBean, S3104InDTO.class);
			S3104OutDTO out = (S3104OutDTO)i3104.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
