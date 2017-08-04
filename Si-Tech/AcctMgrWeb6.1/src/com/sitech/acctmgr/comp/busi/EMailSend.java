package com.sitech.acctmgr.comp.busi;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.utils.XmlUtils;
import com.sitech.acctmgr.comp.webservice.ESBBusiAppException;
import com.sitech.acctmgr.comp.webservice.ESBServiceAxisSoap;

/**
 * 封装发邮件的webservice服务 Created by zhangjp on 2016/8/23.
 */
public class EMailSend extends BaseBusi {

	public Map<String, Object> send(Map<String, Object> Header, Map<String, Object> inParam) {

		String inStr = XmlUtils.map2xml(inParam, "root");
		log.debug("inStr:" + inStr);
		String aa = "<?xml version='1.0' encoding='UTF-8'?><root>" + "<phone_no type='string'>18246139264</phone_no>"
				+ "<templateId type='string'>10000386</templateId>" + "<content type='string'>aa</content>"
				+ "<title_msg type='string'>test</title_msg>" + "</root>";
		String xmlStr = "<?xml version='1.0' encoding='UTF-8'?><root>";
		xmlStr += "<phone_no type='string'>1</phone_no>";
		xmlStr += "<templateId type='string'>00000428</templateId>";
		xmlStr += "<queryDate type='string'>1</queryDate>";
		xmlStr += "<total_prepay type='string'>1</total_prepay>";
		xmlStr += "<spec_prepay type='string'>1</spec_prepay>";
		xmlStr += "<available_bill type='string'>1</available_bill>";
		xmlStr += "<expire_time type='string'>1</expire_time>";
		xmlStr += "<bank_cust type='string'>1</bank_cust>";
		xmlStr += "<pay_code type='string'>1</pay_code>";
		xmlStr += "<pay_name type='string'>1</pay_name>";
		xmlStr += "<pre_bill type='string'>1</pre_bill>";
		xmlStr += "<unbill_owe type='string'>1</unbill_owe>";
		xmlStr += "<show_prepay type='string'>1</show_prepay>";
		xmlStr += "<chSmCode type='string'>1</chSmCode>";
		xmlStr += "<chSmName type='string'>1</chSmName>";
		xmlStr += "<limitowe type='string'>1</limitowe>";
		xmlStr += "<iLoginAccept type='string'>1</iLoginAccept>";
		xmlStr += "<mowpay type='string'>1</mowpay>";
		xmlStr += "<begin_flag type='string'>1</begin_flag>";
		xmlStr += "<lowest_flag type='string'>1</lowest_flag>";
		xmlStr += "<lowest_fee type='string'>1</lowest_fee>";
		xmlStr += "</root>";
		Map<String, Object> outMap = new HashMap<String, Object>();
		try {
			String outStr = ESBServiceAxisSoap.getInstance().callService("emailSendInfo2WS", xmlStr, "1");
			log.debug("outStr:>>>>>>>" + outStr);
			// 将xml格式的字符串转换成Document对象
			outMap = XmlUtils.xml2map(outStr);
			// TODO 根据结果进行判断和处理
			log.debug("outMap:" + outMap);
		} catch (ESBBusiAppException e) {
			e.printStackTrace();
			// TODO throw BusiException
		}
		return outMap;
	}
}
