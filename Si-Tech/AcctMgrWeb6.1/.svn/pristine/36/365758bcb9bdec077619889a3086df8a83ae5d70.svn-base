package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SBackPayInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SSmsBackPayInitOutDTO;
import com.sitech.acctmgr.inter.feeqry.IBackPayQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SBackPayQryTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			IBackPayQry iBackPayQry = (IBackPayQry) getBean("backPayQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20150801\",\"END_DATE\":\"20190801\"}}}}");
			InDTO in = parseInDTO(inMBean, SBackPayInitInDTO.class);
			SSmsBackPayInitOutDTO out = (SSmsBackPayInitOutDTO)iBackPayQry.smsQuery(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

