package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.S3104InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S3104OutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SWlanOpenInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SWlanOpenOutDTO;
import com.sitech.acctmgr.inter.billAccount.I3104;
import com.sitech.acctmgr.inter.billAccount.IWlanOpen;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SWlanOpenTest extends BaseTestCase{

	@Test
	public void testQuery() {
		try {
			IWlanOpen iWlanOpen = (IWlanOpen) getBean("wlanOpenSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\"}}}}");
			InDTO in = parseInDTO(inMBean, SWlanOpenInDTO.class);
			SWlanOpenOutDTO out = (SWlanOpenOutDTO)iWlanOpen.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
