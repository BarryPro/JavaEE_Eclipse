package com.sitech.acctmgr.test.inter;

import org.junit.Test;


import com.sitech.acctmgr.atom.dto.query.ShareAccountQryInDTO;
import com.sitech.acctmgr.atom.dto.query.ShareAccountQryOutDTO;
import com.sitech.acctmgr.inter.query.IShareAccountQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class ShareAccountQryTest extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			IShareAccountQry iShareAccountQry = (IShareAccountQry) getBean("shareAccountQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\",\"OP_CODE\":\"7327\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161264\",\"FLAG\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, ShareAccountQryInDTO.class);
			ShareAccountQryOutDTO out = (ShareAccountQryOutDTO)iShareAccountQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

