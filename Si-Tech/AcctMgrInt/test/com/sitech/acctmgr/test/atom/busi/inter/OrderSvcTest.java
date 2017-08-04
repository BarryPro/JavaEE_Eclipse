package com.sitech.acctmgr.test.atom.busi.inter;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;

import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.acctmgrint.atom.busi.intface.ISvcOrder;
import com.sitech.jcfx.context.JCFContext;

public class OrderSvcTest extends BaseTestCase {

	@Test
	public void testUpdateUserStatusAndCommand() {

		log.info("-----------konglj test ordersvc stt---------");
		//Old Version
		//ISvcOrder iSvcOrder = (ISvcOrder) getBean("SvcOrderEnt");
		//Test Version
		ISvcOrder iSvcOrder = (ISvcOrder) JCFContext.getBean("SvcOrderTestSvc");

		log.info("-----------konglj test ordersvc sss---------");
		Map<String, Object> inParamMap = new HashMap<String, Object>();
		inParamMap.put("PHONE_NO",   "20700039123");
		inParamMap.put("ID_NO",      "230110010000039123");
		inParamMap.put("CONTRACT_NO", "230110010000039123");
		inParamMap.put("GROUP_ID",   "13675");
		inParamMap.put("BRAND_ID",   "2230hn");
		inParamMap.put("RUN_CODE",   "A");
		inParamMap.put("OP_TIME",    "20170307135010");
		inParamMap.put("LOGIN_ACCEPT", "5100008120023");
		//inParamMap.put("CONTACT_ID", "1000008120021");//废弃
		inParamMap.put("LOGIN_NO",   "dd1124");
		inParamMap.put("OP_CODE",    "C200");//信控：c200 
		inParamMap.put("OWNER_FLAG", "1");
		inParamMap.put("OPEN_FLAG",  "2");
		inParamMap.put("BLACK_FLAG",  "1");
		inParamMap.put("FYW_FLAG",  "");
//			Map<String, Object> headMap = new HashMap<String, Object>();
//			headMap.put("DB_ID", "B1");
//		inParamMap.put("HEADER", headMap);
		log.info("--------konglj test--inparam=" + inParamMap.toString());

		try {
			//测试SvcOrderEnt, 没提交，因此不会有数据。
			//使用SvcOrderTestSvc可以提交操作数据。
			iSvcOrder.opUserStatuInter(inParamMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		log.info("-----------konglj test ordersvc end---------");
		
	}

}
