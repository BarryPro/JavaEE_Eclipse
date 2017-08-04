package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8420InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8421InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8421InitOutDTO;
import com.sitech.acctmgr.inter.query.I8420;
import com.sitech.acctmgr.inter.query.I8421;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8421Test extends BaseTestCase{
	@Test
	public void testInit() {
		try {
			I8421 i8421 = (I8421) getBean("8421Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"rrrrrr\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13804310982\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8421InitInDTO.class);
			S8421InitOutDTO out = (S8421InitOutDTO)i8421.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

