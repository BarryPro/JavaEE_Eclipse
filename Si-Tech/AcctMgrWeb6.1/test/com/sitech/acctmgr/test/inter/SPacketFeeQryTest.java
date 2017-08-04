package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SOweIotQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SOweIotQryOutDTO;
import com.sitech.acctmgr.atom.dto.query.SPacketFeeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPacketFeeInitOutDTO;
import com.sitech.acctmgr.inter.billAccount.IPacketFeeQry;
import com.sitech.acctmgr.inter.feeqry.IOweIotQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SPacketFeeQryTest extends BaseTestCase{

	@Test
	public void testquery() {
		try {
			IPacketFeeQry packetFeeQry = (IPacketFeeQry) getBean("packetFeeQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"27081\",\"OP_CODE\":\"6335\",\"PROVINCE_ID\":\"220000\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944162182\",\"LOG_CODE\":\"111111\",\"ORDER_NO\":\"2222222\"}}}}");
			//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
			InDTO in = parseInDTO(inMBean, SPacketFeeInitInDTO.class);
			SPacketFeeInitOutDTO out = (SPacketFeeInitOutDTO)packetFeeQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
