package com.sitech.acctmgr.test.atom.impl.pay;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayMoneyForMrInDTO;
import com.sitech.acctmgr.inter.pay.IFeeOrder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.acctmgrint.common.constant.InterBusiConst;
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
public class SFeeOrderTest extends BaseTestCase{

	private static IFeeOrder feeOrder;
	
	@Before
	public void setUp() throws Exception {
		
		if(feeOrder==null){
			feeOrder = (IFeeOrder)getBean("feeOrderSvc"); 
		}
	}
	
	@Test
	public void testpayMoneyForMr(){
		
		//MBean inParam = new MBean("{ \"ROOT\": { \"HEADER\": { \"ROUTING\": { \"ROUTE_KEY\": \"10\" }, \"TRACE_ID\": \"1115080600000000000011789\", \"CHANNEL_ID\": \"0\" }, \"BODY\": { \"OPR_INFO\": { \"OP_CODE\": \"4602\", \"OP_TIME\": \"20170228184503\", \"LOGIN_NO\": \"gaaa09\", \"ORDER_LINE_ID\": \"L15080600000254\" }, \"BUSI_INFO\": { \"FIRST_EFF\": \"20170228184503\", \"INTERVAL_MONTH\": \"0\", \"RULE_ID\": \"01\", \"PAY_PATH\": \"0\", \"VALID_MONTH\": \"\", \"BUSI_CODE\": \"YXFYHB\", \"ACT_ID\": \"150760000000041762\", \"ACT_TYPE\": \"2\", \"RETURN_MONTH\": \"6\", \"ID_NO\": \"230731000000016303\", \"EXP_DATE\": \"20991231235959\", \"PHONE_NO\": \"13604687015\", \"PAY_FEE\": \"2000\", \"PAY_TYPE\": \"T\", \"MEANS_ID\": \"150751999904000000\", \"EXP_FLAG\": \"0\", \"IS_PRINT\": \"Y\", \"RETURN_FEE\": \"3800+3800+3800+3800+3800+1000\", \"PAY_METHOD\": \"0\" } } } }");
		//MBean inParam = new MBean("{ \"ROOT\": { \"HEADER\": { \"DB_ID\": \"A2\", \"TRACE_ID\": \"11*20170116211019*4660*gaaa04*511320\", \"KEEP_LIVE\": \"10.109.224.34\", \"CHANNEL_ID\": \"0\", \"ENDUSRLOGINID\": \"\", \"PROVINCE_GROUP\": \"HLJ\", \"ENDUSRIP\": \"\", \"ROUTING\": { \"ROUTE_KEY\": \"11\", \"ROUTE_VALUE\": \"230780003012886865\" }, \"REGION_NO\": \"\", \"PHONE_NO\": \"\", \"PARENT_CALL_ID\": \"147976C4598EEB3A2347C65C023C45BE\", \"USERNAME\": \"\", \"ENDUSRLOGINKEY\": \"\", \"PASSWORD\": \"\", \"POOL_ID\": \"2\" }, \"BODY\": { \"OPR_INFO\": { \"OP_CODE\": \"4660\", \"OP_TIME\": \"20170116211721\", \"LOGIN_NO\": \"gaaa04\", \"ACTION_ID\": \"46600\", \"ORDER_LINE_ID\": \"L17011600003300\" }, \"BUSI_INFO\":{ \"INTERVAL_MONTH\": \"1\", \"FIRST_EFF\": \"20170116211031\", \"RULE_ID\": \"01\", \"VALID_MONTH\": \"1\", \"PAY_PATH\": \"0\", \"BUSI_CODE\": \"YXFYHB\", \"MKT_PAY_METHOD\": \"1\", \"ACT_ID\": \"201310235000007101\", \"ACT_TYPE\": \"2\", \"RETURN_MONTH\": \"1\", \"ID_NO\": \"230780003012886865\", \"EXP_DATE\": \"\", \"MKT_TYPE\": \"B\", \"PAY_FEE\": \"4800\", \"PHONE_NO\": \"15214684918\", \"PAY_TYPE\": \"GG\", \"MEANS_ID\": \"201310235000007103\", \"EXP_FLAG\": \"1\", \"IS_PRINT\": \"N\", \"PAY_METHOD\": \"0\", \"RETURN_FEE\": \"4800\" } } } }");
		MBean inParam = new MBean("{\"ROOT\":{\"HEADER\":{\"DB_ID\":\"A2\",\"TRACE_ID\":\"11*20170301153812*4660*gaaa04*337056\",\"KEEP_LIVE\":\"10.109.224.51\",\"CHANNEL_ID\":\"11\",\"ENDUSRLOGINID\":\"\",\"PROVINCE_GROUP\":\"HLJ\",\"ENDUSRIP\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"11\",\"ROUTE_VALUE\":\"230700003013454023\"},\"REGION_NO\":\"\",\"PHONE_NO\":\"\",\"PARENT_CALL_ID\":\"BA5D503F05B0AE3D03E04B4D2C4EAAF1\",\"USERNAME\":\"\",\"ENDUSRLOGINKEY\":\"\",\"PASSWORD\":\"\",\"POOL_ID\":\"2\"},\"BODY\":{\"BUSI_INFO\":{\"INTERVAL_MONTH\":\"1\",\"FIRST_EFF\":\"20170301154032\",\"RULE_ID\":\"01\",\"PAY_PATH\":\"11\",\"VALID_MONTH\":\"12\",\"BUSI_CODE\":\"YXFYHB\",\"MKT_PAY_METHOD\":\"1\",\"ACT_ID\":\"201310235000007101\",\"ACT_TYPE\":\"1\",\"RETURN_MONTH\":\"12\",\"ID_NO\":\"230700003013454023\",\"EXP_DATE\":\"\",\"MKT_TYPE\":\"B\",\"PAY_FEE\":\"12000\",\"PHONE_NO\":\"15045790237\",\"PAY_TYPE\":\"GF\",\"MEANS_ID\":\"201310235000007103\",\"EXP_FLAG\":\"1\",\"IS_PRINT\":\"N\",\"PAY_METHOD\":\"0\",\"RETURN_FEE\":\"1000+1000+1000+1000+1000+1000+1000+1000+1000+1000+1000+1000\"},\"OPR_INFO\":{\"OP_CODE\":\"4660\",\"OP_TIME\":\"20170301154125\",\"LOGIN_NO\":\"gaaa04\",\"ACTION_ID\":\"46600\",\"ORDER_LINE_ID\":\"L17030100001200\"}}}}");
		
		log.info("inParam: " + inParam.toString());
		try {
			InDTO inDto = parseInDTO(inParam, SFeeOrderPayMoneyForMrInDTO.class);
			OutDTO outDTO = feeOrder.payMoneyForMr(inDto);
		} catch (Exception e) {

			e.printStackTrace();
		}
		
	}

	/**
	 * 名称：
	 * @param 
	 * @return 
	 * @throws 
	 */
	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void test() {
		fail("Not yet implemented");
	}

	
		@Test
	public void testaaa() {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("BUSIID_NO", "13694630617");
		inMap.put("BUSIID_TYPE", "1");
		Map<String, Object> outMap = getBcParamExchg(inMap);

		log.debug("qiaolin gan:" + outMap);
	}
	
	
	private static Map<String, Object> getBcParamExchg(Map<String, Object> inMap){
		
		Map<String, Object> outBcMap = new HashMap<String, Object>();
		String sBusiidNo = "";
		
		outBcMap.putAll(inMap);
		
		/*取得BUSIID_TYPE*/
		if (inMap.get("BUSIID_NO") != null)
			sBusiidNo = inMap.get("BUSIID_NO").toString();
		else {
			sBusiidNo = inMap.get("ID_NO").toString();
			//得到BUSIID_NO
			outBcMap.put("BUSIID_NO", sBusiidNo);
		}
		if (sBusiidNo.length() == InterBusiConst.LENGTH_IDNO) {
			outBcMap.put("BUSIID_TYPE", InterBusiConst.BUSIID_TYPE_IDNO);
		} else if (sBusiidNo.length() == InterBusiConst.LENGTH_PHONENO) {
			outBcMap.put("BUSIID_TYPE", InterBusiConst.BUSIID_TYPE_PHONENO);
		} else
			outBcMap.put("BUSIID_TYPE", InterBusiConst.BUSIID_TYPE_OTHER);
	
		return outBcMap;
	}
	
	
	
}
