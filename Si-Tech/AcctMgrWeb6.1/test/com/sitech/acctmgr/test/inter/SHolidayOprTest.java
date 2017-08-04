package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SHolidayOprInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SHolidayOprOutDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeOutDTO;
import com.sitech.acctmgr.inter.acctmng.IHolidayOpr;
import com.sitech.acctmgr.inter.query.IGetDetailType;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SHolidayOprTest extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			IHolidayOpr iHolidayOpr = (IHolidayOpr) getBean("holidayOprSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"BEGIN_TIME\":\"20150801\",\"END_TIME\":\"20190801\",\"REFUND_FLAG\":\"1\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SHolidayOprInDTO.class);
			SHolidayOprOutDTO out = (SHolidayOprOutDTO)iHolidayOpr.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
