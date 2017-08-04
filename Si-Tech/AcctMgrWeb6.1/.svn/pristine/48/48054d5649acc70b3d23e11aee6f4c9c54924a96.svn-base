package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8418InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8418InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8419InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8419InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitOutDTO;
import com.sitech.acctmgr.inter.query.I8418;
import com.sitech.acctmgr.inter.query.I8419;
import com.sitech.acctmgr.inter.query.I8420;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8420Test extends BaseTestCase{
	@Test
	public void testInit() {
		try {
			I8420 i8420 = (I8420) getBean("8420Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"rrrrrr\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000010000\",\"YEAR_MONTH\":\"201604\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8420InitInDTO.class);
			S8420InitOutDTO out = (S8420InitOutDTO)i8420.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
