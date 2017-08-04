package com.sitech.acctmgr.test.inter;

import com.sitech.acctmgr.atom.busi.pay.backfee.BackFeeON;
import com.sitech.acctmgr.atom.dto.pay.S8008CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8008InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8008NoBackInDTO;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.inter.pay.I8008;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;
import org.junit.Before;
import org.junit.Test;

import java.util.Date;

/**
* @Title:   []
* @Description: 
* @Date : 2016年3月16日上午11:02:57
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p> 	
*/
public class S8008Test extends BaseTestCase {

	private I8008 bean = null;
	private BackFeeON tfon = null;
	private String curTime= null;

	@Before
	public void before(){
		bean = (I8008) getBean("8008Svc");
		//tfon = (BackFeeON) getBean("TYCKONEnt");
		curTime = DateUtil.format(new Date(), PayBusiConst.YYYYMMDDHHMMSS);
	}

	
	@Test
	public void  testInit() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aan70W\",\"GROUP_ID\":\"13436\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"CONTRACT_NO\":\"220101100000010000\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeON\"}}}}");

		MBean  mBean2=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15944439651\",\"CONTRACT_NO\":\"220400200024322052\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeDEAD\"}}}}");
		
		MBean  mBean3=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15944439651\",\"CONTRACT_NO\":\"220400200024322052\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeXH\"}}}}");
		
		InDTO inDTO=parseInDTO(mBean, S8008InitInDTO.class);
		OutDTO resulta=bean.init(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	@Test
	public void  testCfm() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aan70W\",\"GROUP_ID\":\"13436\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\",\"CONTRACT_NO\":\"220101100000010000\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeON\""
				+ ",\"PAY_MONEY\":200,\"PAY_PATH\":\"11\",\"PAY_METHOD\":\"0\""
				+ "}}}}");

		MBean  mBean2=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15944439651\",\"CONTRACT_NO\":\"220400200024322052\""
				+ ",\"IN_IF_ONNET\":\"2\",\"OP_TYPE\":\"BackFeeDEAD\""
				+ ",\"PAY_MONEY\":3,\"PAY_PATH\":\"11\",\"PAY_METHOD\":\"0\""
				+ "}}}}");
		
		MBean  mBean3=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15944439651\",\"CONTRACT_NO\":\"220400200024322052\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeXH\""
				+ ",\"PAY_MONEY\":-4,\"PAY_PATH\":\"11\",\"PAY_METHOD\":\"0\""
				+ "}}}}");
		MBean  mBean4=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15886095842\",\"CONTRACT_NO\":\"220400200024322051\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeLDKC\""
				+ ",\"PAY_MONEY\":5,\"PAY_PATH\":\"11\",\"PAY_METHOD\":\"0\""
				+ "}}}}");
		InDTO inDTO=parseInDTO(mBean, S8008CfmInDTO.class);
		OutDTO resulta=bean.cfm(inDTO);

		System.out.println("----->"+resulta.toJson());
		
	}
 
	@Test
	public void  testNoBack() throws Exception{
		MBean  mBean=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15886095842\",\"CONTRACT_NO\":\"220400200024322051\""
				+ ",\"IN_IF_ONNET\":\"1\",\"OP_TYPE\":\"BackFeeON\"}}}}");

		MBean  mBean2=new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},"
				+ "\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"dd1124\",\"GROUP_ID\":\"1130\",\"OP_CODE\":\"8008\",\"PROVINCE_ID\":\"220000\"},"
				+ "\"BUSI_INFO\":{\"PHONE_NO\":\"15944439651\",\"CONTRACT_NO\":\"220400200024322052\""
				+ ",\"IN_IF_ONNET\":\"2\",\"OP_TYPE\":\"BackFeeDEAD\"}}}}");
 
		InDTO inDTO=parseInDTO(mBean2, S8008NoBackInDTO.class);
		OutDTO resulta=bean.noBackMoney(inDTO);

		System.out.println("----->"+resulta.toJson());
	}
	
	public static void main(String[] args) {

		/*
		int iCurYm = Integer.parseInt(DateUtil.format(new Date(), "yyyyMM"));
		int iMinYm=Integer.parseInt(DateUtil.toStringPlusMonths(new Date(), -5, "yyyyMM"));
		System.out.println("--iCurYm:"+iCurYm);
		System.out.println("--iMinYm:"+iMinYm);
		System.out.println(DateUtil.toStringPlusSeconds("20141016165959", -1, "yyyyMMddHHmmss"));
		long remain_money=6;
		if (remain_money>0.005||remain_money<-0.005)		  {
			System.out.println(1);
		}
		System.out.println(2);
		*/
		
	}

}
