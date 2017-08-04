package com.sitech.acctmgr.test.inter;

import com.sitech.acctmgr.atom.dto.feeqry.*;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Test;

import com.sitech.acctmgr.inter.feeqry.IBackPayQry;
import com.sitech.acctmgr.inter.feeqry.IBalance;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SBalanceTest extends BaseTestCase{
	@Test
	public void testQuery() {
		try {
			IBalance iBalance = (IBalance) getBean("balanceSvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"13944161268\",\"FOREIGN_SN\":\"L16050400000006\",\"FOREIGN_TIME\":\"20150606060606\"}}}}");
			InDTO in = parseInDTO(inMBean, SBalanceQryRestPayInDTO.class);
			SBalanceQryRestPayOutDTO out = (SBalanceQryRestPayOutDTO)iBalance.qryRestPay(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testQueryBackFee() {
		IBalance bean = (IBalance) getBean("balanceSvc");
		MBean inMbean = new MBean("{\n" +
				"    \"ROOT\": {\n" +
				"        \"HEADER\": {\n" +
				"            \"DB_ID\": \"B1\",\n" +
				"            \"ROUTING\": {\n" +
				"                \"ROUTE_KEY\": \"11\",\n" +
				"                \"ROUTE_VALUE\": \"230370003021702700\"\n" +
				"            },\n" +
				"            \"KEEP_LIVE\": \"10.109.224.16\",\n" +
				"            \"TRACE_ID\": \"11*20170329033007*1052*csgj07*880403\",\n" +
				"            \"CHANNEL_ID\": \"11\",\n" +
				"            \"PARENT_CALL_ID\": \"ABB474D67532D2B01183B1A457460C24\",\n" +
				"            \"POOL_ID\": \"1\",\n" +
				"            \"SERVICE_ROUTECALL\": \"1\"\n" +
				"        },\n" +
				"        \"BODY\": {\n" +
				"            \"BUSI_INFO\": {\n" +
				"                \"CONTRACT_NO\": \"230330003015749302\"\n" +
				"            },\n" +
				"            \"OPR_INFO\": {\n" +
				"                \"OP_CODE\": \"1055\",\n" +
				"                \"GROUP_ID\": \"\",\n" +
				"                \"LOGIN_NO\": \"csgj07\",\n" +
				"                \"PROVINCE_ID\": \"230000\"\n" +
				"            }\n" +
				"        }\n" +
				"    }\n" +
				"}");

		InDTO in = parseInDTO(inMbean, SBalanceQryBackFeeInDTO.class);
		OutDTO out = bean.queryBackFee(in);
		String result = out.toJson();
		System.out.println("result = " + result);
	}
}
