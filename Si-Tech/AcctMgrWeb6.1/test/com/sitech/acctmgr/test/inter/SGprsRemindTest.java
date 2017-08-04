package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsTimeRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SIntegratedRemindInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeOutDTO;
import com.sitech.acctmgr.inter.billAccount.IGprsRemind;
import com.sitech.acctmgr.inter.query.IGetDetailType;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SGprsRemindTest extends BaseTestCase{
	
	@Test
	public void testGprsRemind() {
		try {
			IGprsRemind iGprsRemind = (IGprsRemind) getBean("gprsRemindSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"A\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SGprsRemindInDTO.class);
			SGprsRemindOutDTO out = (SGprsRemindOutDTO)iGprsRemind.gprsRemind(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGprsRemindNew() {
		try {
			IGprsRemind iGprsRemind = (IGprsRemind) getBean("gprsRemindSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6336\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"D\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SGprsRemindInDTO.class);
			SGprsRemindOutDTO out = (SGprsRemindOutDTO)iGprsRemind.gprsRemindNew(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGprsInterRemind() {
		try {
			IGprsRemind iGprsRemind = (IGprsRemind) getBean("gprsRemindSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6337\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"A\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SGprsRemindInDTO.class);
			SGprsRemindOutDTO out = (SGprsRemindOutDTO)iGprsRemind.gprsInterRemind(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testIntegratedRemind() {
		try {
			IGprsRemind iGprsRemind = (IGprsRemind) getBean("gprsRemindSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"newsms\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6338\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"D\",\"OP_FLAG\":\"0\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SIntegratedRemindInDTO.class);
			SGprsRemindOutDTO out = (SGprsRemindOutDTO)iGprsRemind.integratedRemind(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGprsTimeRemind() {
		try {
			IGprsRemind iGprsRemind = (IGprsRemind) getBean("gprsRemindSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"newsms\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6339\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"D\",\"OP_FLAG\":\"0\",\"CALL_CYCLE\":\"1\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SGprsTimeRemindInDTO.class);
			SGprsRemindOutDTO out = (SGprsRemindOutDTO)iGprsRemind.gprsTimeRemind(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
