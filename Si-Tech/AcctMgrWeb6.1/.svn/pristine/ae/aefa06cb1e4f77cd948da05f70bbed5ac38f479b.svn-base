package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.SCreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryDetailInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryDetailOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQueryForCrmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQueryForCrmOutDTO;
import com.sitech.acctmgr.inter.cct.ICredit;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SCreditTest extends BaseTestCase{

	@Test
	public void testQuery() {
		try {
			ICredit iCredit = (ICredit) getBean("creditSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12385\",\"OP_CODE\":\"8288\",\"PROVINCE_ID\":\"230000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944160463\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SCreditQryInDTO.class);
			SCreditQryOutDTO out = (SCreditQryOutDTO)iCredit.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testQueryForCrm() {
		try {
			ICredit iCredit = (ICredit) getBean("creditSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8288\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"ID_NO\":\"220271000000007738\",\"OP_TIME\":\"1111\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SCreditQueryForCrmInDTO.class);
			SCreditQueryForCrmOutDTO out = (SCreditQueryForCrmOutDTO)iCredit.queryForCrm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testQueryDetail() {
		try {
			ICredit iCredit = (ICredit) getBean("creditSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8288\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944160463\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SCreditQryDetailInDTO.class);
			SCreditQryDetailOutDTO out = (SCreditQryDetailOutDTO)iCredit.queryDetail(in);
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
			ICredit iCredit = (ICredit) getBean("creditSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"8288\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"CUST_NAME\":\"xxxxxx\",\"CUST_ICID\":\"123456\",\"REMIND_PHONE\":\"18634310486\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SCreditCfmInDTO.class);
			SCreditCfmOutDTO out = (SCreditCfmOutDTO)iCredit.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
