package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S8128QueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8128QueryOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitOutDTO;
import com.sitech.acctmgr.inter.feeqry.I8128;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8128Test  extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			I8128 i8128 = (I8128) getBean("8128Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8128QueryInDTO.class);
			S8128QueryOutDTO out = (S8128QueryOutDTO)i8128.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
