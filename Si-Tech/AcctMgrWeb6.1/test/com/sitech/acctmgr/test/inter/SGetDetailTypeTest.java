package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8124InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8124InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeOutDTO;
import com.sitech.acctmgr.inter.query.I8124;
import com.sitech.acctmgr.inter.query.IGetDetailType;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SGetDetailTypeTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			IGetDetailType iGetDetailType = (IGetDetailType) getBean("getDetailTypeSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"DETAIL_TYPE\":\"\",\"QUERY_TYPE\":\"\"}}}}");

			InDTO in = parseInDTO(inMBean, SGetDetailTypeInDTO.class);
			SGetDetailTypeOutDTO out = (SGetDetailTypeOutDTO)iGetDetailType.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
