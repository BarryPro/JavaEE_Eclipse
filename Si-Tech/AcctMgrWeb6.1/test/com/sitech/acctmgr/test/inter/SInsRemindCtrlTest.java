package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SInsRemindCtrlInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SInsRemindCtrlOutDTO;
import com.sitech.acctmgr.inter.billAccount.IGprsRemind;
import com.sitech.acctmgr.inter.billAccount.IInsRemindCtrl;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SInsRemindCtrlTest extends BaseTestCase{

	@Test
	public void testGprsRemind() {
		try {
			IInsRemindCtrl insRemindCtrl = (IInsRemindCtrl) getBean("insRemindCtrlSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6335\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161239\",\"OP_TYPE\":\"KTDXTX\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SInsRemindCtrlInDTO.class);
			SInsRemindCtrlOutDTO out = (SInsRemindCtrlOutDTO)insRemindCtrl.cfm(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
