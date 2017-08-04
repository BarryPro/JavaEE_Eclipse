package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S8510InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8510OutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8511InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8511OutDTO;
import com.sitech.acctmgr.inter.billAccount.I8510;
import com.sitech.acctmgr.inter.billAccount.I8511;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8511Test extends BaseTestCase{
	
	@Test
	public void testCfm() {
		try {
			I8511 i8511 = (I8511) getBean("8511Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"e224\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18246162371\",\"OP_TYPE\":\"1\",\"SHOULD_PAY\":\"150\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8511InDTO.class);
			S8511OutDTO out = (S8511OutDTO)i8511.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
