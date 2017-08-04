package com.sitech.acctmgr.test.inter;

import static org.junit.Assert.*;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8109InDTO;
import com.sitech.acctmgr.atom.dto.query.S8109OutDTO;
import com.sitech.acctmgr.inter.query.I8109;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcf.json.JSONObject;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8109Test extends BaseTestCase {

	@Test
	public void testQuery() {
		try {
			I8109 i8109 = (I8109) getBean("8109Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"ID_NO\":\"220121000000008271\",\"CONTRACT_NO\":\"220101100000040014\", \"PHONE_NO\":\"13804310983\",\"BEGIN_DATE\":\"20030801\", \"END_DATE\":\"20030831\",\"USER_FLAG\":\"2\"}}}}");
			InDTO in = parseInDTO(inMBean, S8109InDTO.class);
			S8109OutDTO out = (S8109OutDTO)i8109.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}


