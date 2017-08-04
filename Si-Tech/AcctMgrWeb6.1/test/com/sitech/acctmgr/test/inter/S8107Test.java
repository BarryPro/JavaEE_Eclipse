package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.jcfx.dt.MBean;
import com.sitech.acctmgr.atom.dto.feeqry.S8107QryBillDetailInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8107QryBillInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8107QryPayInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8107QueryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.inter.feeqry.I8107;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class S8107Test extends BaseTestCase {

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.impl.S8107#s8107Qry(java.lang.String)}.
	 * @throws Exception 
	 */
//	@Ignore
	@Test
	public void testQuery() throws Exception {
		String inParam = "{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
				"		,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"361629\",\"OP_CODE\":\"8107\",\"PROVINCE_ID\":\"230000\"},\"BUSI_INFO\":{\"USER_FLAG\":\"0\",\"PHONE_NO\":\"13944162154\"}}}}";
		MBean inMBean = new MBean(inParam);
		InDTO in = parseInDTO(inMBean, S8107QueryInDTO.class);
		I8107 i8107 = (I8107) getBean("8107Svc");
		OutDTO result = i8107.query(in);
		System.out.println("result = " + result.toJson().toString());
	}

	/**
	 * Test method for {@link com.sitech.acctmgr.atom.impl.S8107#s8107PayQry(java.lang.String)}.
	 * @throws Exception 
	 */
//	@Ignore
	@Test
	public void testQryPay() throws Exception {
		String inParam = "{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"13765\",\"OP_CODE\":\"8107\"},\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000040004\", \"BEGIN_TIME\":\"20151201\", \"END_TIME\":\"20161211\"}}}}";
		MBean inMBean = new MBean(inParam);
		InDTO in = parseInDTO(inMBean, S8107QryPayInDTO.class);
		I8107 i8107 = (I8107) getBean("8107Svc");
		OutDTO result = i8107.qryPay(in);
		System.out.println("result = " + result.toJson().toString());
	}

//	@Ignore
	@Test
	public void testQryBill() throws Exception {
//		String inParam = "{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
//				"		,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"OP_CODE\":\"8166\"},\"BUSI_INFO\":{\"CONTRACT_NO\":\"27102350370761\", \"PHONE_NO\":\"13981053052\",\"ID_NO\":\"27102350370761\",\"USER_FLAG\":\"1\"}}}}";
		String inParam = "{\"ROOT\":{\"BODY\":{\"BUSI_INFO\":{\"BEGIN_TIME\":\"20150111\",\"CONTRACT_NO\":\"220101100000080001\",\"END_TIME\":\"20161211\",\"ID_NO\":\"220131000000009305\",\"IN_UUID\":\"cb99e8d8-957c-40f7-a2d8-a0bf371961f7\",\"PAGE_NUM\":\"\",\"PHONE_NO\":\"13990215389\",\"USER_FLAG\":\"0\"},\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"OP_CODE\":\"8107\"}},\"HEADER\":{\"CHANNEL_ID\":\"11\",\"CONTACT_ID\":\"\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"10.208.234.234\",\"POOL_ID\":\"2\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"},\"SUB_TRACE_ID\":\"\"}}}";
		MBean inMBean = new MBean(inParam);
		InDTO in = parseInDTO(inMBean, S8107QryBillInDTO.class);
		I8107 i8107 = (I8107) getBean("8107Svc");
		OutDTO result = i8107.qryBill(in);
		System.out.println("result = " + result.toJson().toString());
	}
	
	@Test
	public void testQryBillDetail() throws Exception {
		String inParam = "{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"13765\",\"OP_CODE\":\"8107\"},\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000080001\", \"ID_NO\":\"220131000000009305\", \"STATUS\":\"0\", \"BILL_CYCLE\":\"201606\"}}}}";
		MBean inMBean = new MBean(inParam);
		InDTO in = parseInDTO(inMBean, S8107QryBillDetailInDTO.class);
		I8107 i8107 = (I8107) getBean("8107Svc");
		OutDTO result = i8107.qryBillDetail(in);
		System.out.println("result = " + result.toJson().toString());
	}
	
}
