package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SPayTypeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitOutDTO;
import com.sitech.acctmgr.atom.dto.query.SUserRunTimeQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SUserRunTimeQryOutDTO;
import com.sitech.acctmgr.inter.query.IPayTypeQry;
import com.sitech.acctmgr.inter.query.IUserRunTimeQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SUserRunTimeQryTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			IUserRunTimeQry iUserRunTimeQry = (IUserRunTimeQry) getBean("userRunTimeQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944160006\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SUserRunTimeQryInDTO.class);
			SUserRunTimeQryOutDTO out = (SUserRunTimeQryOutDTO)iUserRunTimeQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
