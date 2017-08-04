package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S17951IpFeeInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S17951IpFeeInitOutDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitOutDTO;
import com.sitech.acctmgr.inter.feeqry.I17951IpFeeQry;
import com.sitech.acctmgr.inter.query.IPayTypeQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S17951IpFeeQryTest extends BaseTestCase{
	
	@Test
	public void testQuery() {
		try {
			I17951IpFeeQry i17951IpFeeQry = (I17951IpFeeQry) getBean("17951IpFeeQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161254\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S17951IpFeeInitInDTO.class);
			S17951IpFeeInitOutDTO out = (S17951IpFeeInitOutDTO)i17951IpFeeQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
