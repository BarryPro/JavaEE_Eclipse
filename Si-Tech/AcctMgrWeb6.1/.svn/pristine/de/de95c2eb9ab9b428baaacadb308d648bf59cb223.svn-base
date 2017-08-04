package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SPayMoreQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayMoreQryOutDTO;
import com.sitech.acctmgr.inter.feeqry.IPayMoreQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SPayMoreQryTest extends BaseTestCase{
	
	@Test
	public void testPayQuery() {
		try {
			IPayMoreQry iPayMoreQry = (IPayMoreQry) getBean("payMoreQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPayMoreQryInDTO.class);
			SPayMoreQryOutDTO out = (SPayMoreQryOutDTO)iPayMoreQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
