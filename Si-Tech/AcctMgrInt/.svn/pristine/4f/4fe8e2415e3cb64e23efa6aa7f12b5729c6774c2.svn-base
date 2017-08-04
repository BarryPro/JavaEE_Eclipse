package com.sitech.acctmgrint.atom.busi.intface;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgrint.common.IntControl;
import com.sitech.acctmgrint.common.utils.ValueUtils;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class SendMsg {
	static{
		XMLFileContext.addXMLFile("applicationContext-svcodr.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();
	}

	private static Logger log = Logger.getLogger(SendMsg.class);
	//后台定义：springcfgsvcodr目录下，重新定义一个事务提交的Bean SvcOrderSvc
	private static IntControl control = LocalContextFactory.getInstance().getBean("controlEnt", IntControl.class);
	private static IShortMessage shortMessage = LocalContextFactory.getInstance().getBean("ShortMessageSvc", IShortMessage.class);
	private void sendpayMsg(String phoneNoSign, String phoneNoPay, long payMoney, String loginNo, String opCode){ 
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss"); 
		Map<String, Object> mapTmp = new HashMap<String, Object>(); 
		Map<String, Object> mapTmp2 = new HashMap<String, Object>(); 
		MBean inMessage = new MBean(); 
		if(phoneNoSign.equals(phoneNoPay)){ 
			//BOSS_6014: 尊敬的客户，您本次使用“易充值”成功充值${pay_money}元。中国移动${sms_release} 
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(payMoney)); 
			mapTmp.put("sms_release", ""); 
			inMessage.addBody("TEMPLATE_ID", "311200806901"); 

		}else{ 
			//BOSS_6016: 尊敬的客户，您于${year}年${month}月${day}日${hour}时${minute}分，使用“易充值”成功为手机号码${phone_no}充值${pay_money}元。【中国移动】 
			mapTmp.put("year", sCurTime.substring(0, 4)); 
			mapTmp.put("month", sCurTime.substring(4, 6)); 
			mapTmp.put("day", sCurTime.substring(6, 8)); 
			mapTmp.put("hour", sCurTime.substring(8, 10)); 
			mapTmp.put("minute", sCurTime.substring(10, 12)); 
			mapTmp.put("phone_no", phoneNoPay); 
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(payMoney)); 
			inMessage.addBody("TEMPLATE_ID", "311200806902"); 

			//BOSS_6017: 尊敬的客户，手机号码${phone_no}于${year}年${month}月${day}日${hour}时${minute}分，使用“易充值”为您充值${pay_money}元。【中国移动】 
			mapTmp2.put("phone_no", phoneNoSign); 
			mapTmp2.put("year", sCurTime.substring(0, 4)); 
			mapTmp2.put("month", sCurTime.substring(4, 6)); 
			mapTmp2.put("day", sCurTime.substring(6, 8)); 
			mapTmp2.put("hour", sCurTime.substring(8, 10)); 
			mapTmp2.put("minute", sCurTime.substring(10, 12)); 
			mapTmp2.put("pay_money", ValueUtils.transFenToYuan(payMoney)); 
		} 

		inMessage.addBody("PHONE_NO", phoneNoSign); 
		inMessage.addBody("LOGIN_NO", loginNo);; 
		inMessage.addBody("OP_CODE", opCode); 
		inMessage.addBody("CHECK_FLAG", true); 
		inMessage.addBody("DATA", mapTmp); 
		inMessage.addBody("SEND_FLAG", 0); 
		//		String flag = control.getPubCodeValue(2011, "DXFS", null); // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信 

		log.info("发送短信内容：" + inMessage.toString()); 
		shortMessage.sendSmsMsg(inMessage, 1); 

	}
	public static void main(String[] args) {
		SendMsg sendMsg = new SendMsg();
//		sendMsg.sendpayMsg(phoneNoSign, phoneNoPay, payMoney, loginNo, opCode);
	}
}
