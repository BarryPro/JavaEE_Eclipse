package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S8293InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293OutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412OweBillQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412OweBillQryOutDTO;
import com.sitech.acctmgr.inter.acctmng.I8293;
import com.sitech.acctmgr.inter.feeqry.I8412;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8412Test extends BaseTestCase{
	@Test
	public void testOweBillQry() {
		try {
			I8412 i8412 = (I8412) getBean("8412Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000080001\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8412OweBillQryInDTO.class);
			S8412OweBillQryOutDTO out = (S8412OweBillQryOutDTO)i8412.qryOweBill(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
