package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.S8006CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8006InitInDTO;
import com.sitech.acctmgr.inter.pay.I8006;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class S8006Test extends BaseTestCase {

	private I8006 bean = null;

	@Before
	public void before() {
		bean = (I8006) getBean("8006Svc");
	}

	@Test
	public void testInit() throws Exception {
		MBean mBean = new MBean(
				"{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
						+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8006\",\"PROVINCE_ID\":\"220000\"},"
						+ "\"BUSI_INFO\":{\"PHONE_NO\":\"13804310983\",\"ID_NO\":\"220121000000008271\",\"BACK_TYPE\":\"1\"}}}}");

		InDTO inDTO = parseInDTO(mBean, S8006InitInDTO.class);
		OutDTO result = bean.init(inDTO);

		System.out.println("----->" + result.toJson());
	}

	@Test
	public void testCfm() throws Exception {
		MBean inParam = new MBean(
				"{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
						+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8006\",\"PROVINCE_ID\":\"220000\"},"
						+ "\"BUSI_INFO\":{\"ID_NO\":\"220121000000008271\",\"PHONE_NO\":\"13804310983\",\"PAY_MONEY\":\"0\",\"PAY_TYPE\":\"0\",\"SHOULD_PAY\":\"0\",\"BANK_CODE\":\"\",\"CHECK_NO\":\"\",\"BACK_TYPE\":\"1\",\"PAY_PATH\":\"01\",\"PAY_METHOD\":\"0\",\"DELAY_RATE\":\"0.5\",\"PAY_NOTE\":\"\",\"BILL_YM_STR\":\"201606|201607\"}}}}");

		InDTO inDTO = parseInDTO(inParam, S8006CfmInDTO.class);
		OutDTO result = bean.cfm(inDTO);

		System.out.println("----->" + result.toJson());
	}

}
