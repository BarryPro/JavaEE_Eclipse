package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S8422InitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8422InitOutDTO;
import com.sitech.acctmgr.inter.feeqry.I8422;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8422Test extends BaseTestCase{
	@Test
	public void testInit() {
		try {
			I8422 i8422 = (I8422) getBean("8422Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"rrrrrr\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"UNIT_ID\":\"4311000013\"}}}}");
			InDTO in = parseInDTO(inMBean, S8422InitInDTO.class);
			S8422InitOutDTO out = (S8422InitOutDTO)i8422.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
