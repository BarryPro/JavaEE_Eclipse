package com.sitech.acctmgr.test.inter;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.adj.S8010CfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8010InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8295CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8296DeleteInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8296InitHisInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8296InitRecdInDTO;
import com.sitech.acctmgr.inter.adj.I8010;
import com.sitech.acctmgr.inter.pay.I8295;
import com.sitech.acctmgr.inter.pay.I8296;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
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
public class S8296Test extends BaseTestCase {
	
	private I8296 bean = null;

	@Before
	public void before(){
		bean = (I8296) getBean("8296Svc");
	}

	 
	@Test
	public void  testDel() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{"
				+ "\"GROUP_CONTRACT_NO\":\"220101100000000000\""
				+ "}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8296DeleteInDTO.class);
		OutDTO resulta=bean.del(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testInitRecd() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{"
				+ "\"GROUP_CONTRACT_NO\":\"220101100000000000\""
				+ "}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8296InitRecdInDTO.class);
		OutDTO resulta=bean.initRecd(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	
	@Test
	public void  testInitHis() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{"
				+ "\"GROUP_CONTRACT_NO\":\"220101100000000000\""
				+ ",\"BEGIN_TIME\":\"20160814\""
				+ ",\"END_TIME\":\"20160816\""
				+ "}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8296InitHisInDTO.class);
		OutDTO resulta=bean.initHis(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testInitErr() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{"
				+ "\"GROUP_CONTRACT_NO\":\"220101100000000000\""
				+ ",\"BEGIN_TIME\":\"20160814\""
				+ ",\"END_TIME\":\"20160816\""
				+ "}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8296InitHisInDTO.class);
		OutDTO resulta=bean.initHis(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testCfm() throws Exception{
		MBean inParam=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"KEEP_LIVE\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaRB00\",\"GROUP_ID\":\"21430\",\"OP_CODE\":\"8295\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{"
				+ "\"GROUP_CONTRACT_NO\":\"220101100000000000\""
				+ "}}}}"); 

		InDTO inDTO=parseInDTO(inParam, S8296InitRecdInDTO.class);
		OutDTO resulta=bean.initRecd(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
}
