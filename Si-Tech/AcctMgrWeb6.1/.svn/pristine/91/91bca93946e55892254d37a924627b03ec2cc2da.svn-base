package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.S8157CfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CreditCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157InitInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157InitOutDTO;
import com.sitech.acctmgr.inter.cct.I8157;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8157Test extends BaseTestCase {

	@Test
	public void testQuery() {
		try {
			I8157 i8157 = (I8157) getBean("8157Svc");

			MBean inMBean = new MBean(
					"{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}"
							+ "    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
							+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\"}}}}");
			// InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8157InitInDTO.class);
			S8157InitOutDTO out = (S8157InitOutDTO) i8157.init(in);
			String result = out.toJson();
			System.out.println("result = " + result);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testCfm() {
		try {
			I8157 i8157 = (I8157) getBean("8157Svc");

			MBean inMBean = new MBean(
					"{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}"
							+ "    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
							+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"CREDIT_CLASS\":\"c\",\"OP_NOTE\":\"xiongjy\"}}}}");
			// InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8157CfmInDTO.class);
			S8157CfmOutDTO out = (S8157CfmOutDTO) i8157.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testCreditCfm() {
		try {
			I8157 i8157 = (I8157) getBean("8157Svc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8293\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"OLD_CREDIT\":\"100\",\"NEW_CREDIT\":\"50\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, S8157CreditCfmInDTO.class);
			S8157CreditCfmOutDTO out = (S8157CreditCfmOutDTO) i8157.creditCfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
