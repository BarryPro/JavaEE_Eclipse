package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S8424QryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8424QryOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8421InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8421InitOutDTO;
import com.sitech.acctmgr.inter.query.I8420;
import com.sitech.acctmgr.inter.query.I8421;
import com.sitech.acctmgr.inter.query.I8424;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8424Test extends BaseTestCase{
	@Test
	public void testInit() {
		try {
			I8424 i8424 = (I8424) getBean("8424Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"rrrrrr\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161254\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8424QryInDTO.class);
			S8424QryOutDTO out = (S8424QryOutDTO)i8424.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

