package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.SCreditQryInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryOutDTO;
import com.sitech.acctmgr.atom.dto.query.SAgentOprInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SAgentOprInitOutDTO;
import com.sitech.acctmgr.inter.cct.ICredit;
import com.sitech.acctmgr.inter.query.IAgentOprQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SAgentOprQryTest extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			IAgentOprQry iAgentOprQry = (IAgentOprQry) getBean("agentOprQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8288\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"AGT_PHONE_NO\":\"13944161265\",\"QUERY_TYPE\":\"3\",\"PHONE_NO\":\"18663000630\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SAgentOprInitInDTO.class);
			SAgentOprInitOutDTO out = (SAgentOprInitOutDTO)iAgentOprQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
