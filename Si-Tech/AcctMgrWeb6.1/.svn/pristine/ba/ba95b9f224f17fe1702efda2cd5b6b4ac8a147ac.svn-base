package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBackPayInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBackPayQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBackPayQryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SMallPayQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SMallPayQryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPay1500QryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPay1500QryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayFlagQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayFlagQryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayQueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayQueryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPhonePayNewInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPhonePayNewOutDTO;
import com.sitech.acctmgr.inter.billAccount.IGprsRemind;
import com.sitech.acctmgr.inter.feeqry.IPayQuery;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SPayQueryTest extends BaseTestCase{
	
	@Test
	public void testPayQuery() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPayQueryInDTO.class);
			SPayQueryOutDTO out = (SPayQueryOutDTO)iPayQuery.qryPayInfo(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testSPhonePayNew() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"18502\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"SYS_DATE\":\"20151201\", \"END_DATE\":\"20161211\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPayFlagQryInDTO.class);
			SPayFlagQryOutDTO out = (SPayFlagQryOutDTO)iPayQuery.payFlagQry(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testPayFlag() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPayQueryInDTO.class);
			SPayQueryOutDTO out = (SPayQueryOutDTO)iPayQuery.qryPayInfo(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testSPay1500Qry() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"18502\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPay1500QryInDTO.class);
			SPay1500QryOutDTO out = (SPay1500QryOutDTO)iPayQuery.pay1500Qry(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testSMallPayQry() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"18502\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\",\"OTHER_FLAG\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SMallPayQryInDTO.class);
			SMallPayQryOutDTO out = (SMallPayQryOutDTO)iPayQuery.mallPayQry(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testBackPayQry() {
		try {
			IPayQuery iPayQuery = (IPayQuery) getBean("payQuerySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"18502\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"BEGIN_DATE\":\"20151201\", \"END_DATE\":\"20161211\",\"OTHER_FLAG\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SBackPayQryInDTO.class);
			SBackPayQryOutDTO out = (SBackPayQryOutDTO)iPayQuery.backPayQry(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
