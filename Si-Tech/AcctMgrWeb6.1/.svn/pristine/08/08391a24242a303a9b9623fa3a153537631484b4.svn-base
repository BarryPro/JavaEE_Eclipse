package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeOutDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitOutDTO;
import com.sitech.acctmgr.inter.query.IGetDetailType;
import com.sitech.acctmgr.inter.query.IPayTypeQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SPayTypeTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			IPayTypeQry iPayTypeQry = (IPayTypeQry) getBean("payTypeQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"QUERY_FLAG\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPayTypeInitInDTO.class);
			SPayTypeInitOutDTO out = (SPayTypeInitOutDTO)iPayTypeQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
