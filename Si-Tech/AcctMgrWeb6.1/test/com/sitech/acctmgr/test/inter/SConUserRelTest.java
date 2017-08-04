package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBackPayInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SSmsBackPayInitOutDTO;
import com.sitech.acctmgr.inter.acctmng.IConUserRel;
import com.sitech.acctmgr.inter.feeqry.IBackPayQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SConUserRelTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			IConUserRel iConUserRel = (IConUserRel) getBean("conUserRelSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"13789\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13704838818\"}}}}");
			InDTO in = parseInDTO(inMBean, SConUserRelInDTO.class);
			SConUserRelOutDTO out = (SConUserRelOutDTO)iConUserRel.queryOnLine(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
