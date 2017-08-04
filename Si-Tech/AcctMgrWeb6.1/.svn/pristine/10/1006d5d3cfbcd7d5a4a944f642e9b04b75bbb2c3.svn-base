package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeInDTO;
import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeOutDTO;
import com.sitech.acctmgr.atom.dto.query.STopPayTransQryInDTO;
import com.sitech.acctmgr.atom.dto.query.STopPayTransQryOutDTO;
import com.sitech.acctmgr.inter.billAccount.ISmsRightJudge;
import com.sitech.acctmgr.inter.query.ITopPayTransQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class STopPayTransQryTest extends BaseTestCase{
	@Test
	public void testTopPayTransQry() {
		try {
			ITopPayTransQry iTopPayTransQry = (ITopPayTransQry) getBean("topPayTransQrySvc");

			MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
				+ ",\"BUSI_INFO\":{\"ACTION_DATE\":\"20160601\",\"TRANSACTION_ID\":\"10999201606010742323317116236182\"}}}}");
			InDTO in = parseInDTO(inMBean, STopPayTransQryInDTO.class);
			STopPayTransQryOutDTO out = (STopPayTransQryOutDTO)iTopPayTransQry.query(in);
			String result = out.toJson();
			System.out.println("result = " + result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
