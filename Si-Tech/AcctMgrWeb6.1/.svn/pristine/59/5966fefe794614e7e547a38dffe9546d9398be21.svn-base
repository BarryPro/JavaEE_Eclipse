package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeCfmInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeCfmOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeQryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeQryOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.STellCodeInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.STellCodeOutDTO;
import com.sitech.acctmgr.atom.dto.query.SDisFlagQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SDisFlagQryOutDTO;
import com.sitech.acctmgr.inter.billAccount.IChargeFee;
import com.sitech.acctmgr.inter.query.IDisFlagQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SChargeFeeTest extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			IChargeFee iChargeFee = (IChargeFee) getBean("chargeFeeSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SChargeFeeQryInDTO.class);
			SChargeFeeQryOutDTO out = (SChargeFeeQryOutDTO)iChargeFee.query(in);
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
			IChargeFee iChargeFee = (IChargeFee) getBean("chargeFeeSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"KTKFTX\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SChargeFeeCfmInDTO.class);
			SChargeFeeCfmOutDTO out = (SChargeFeeCfmOutDTO)iChargeFee.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testTellA() {
		try {
			IChargeFee iChargeFee = (IChargeFee) getBean("chargeFeeSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"LOGIN_ACCEPT\":\"8013\"}}}}");
			InDTO in = parseInDTO(inMBean, STellCodeInDTO.class);
			STellCodeOutDTO out = (STellCodeOutDTO)iChargeFee.uTellCodeA(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testTellB() {
		try {
			IChargeFee iChargeFee = (IChargeFee) getBean("chargeFeeSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"LOGIN_ACCEPT\":\"8013\"}}}}");
			InDTO in = parseInDTO(inMBean, STellCodeInDTO.class);
			STellCodeOutDTO out = (STellCodeOutDTO)iChargeFee.uTellCodeB(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

