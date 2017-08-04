package com.sitech.acctmgr.app.busiorder;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jms.JMSException;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;

import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcfx.dt.MBean;

public class BusiOrderSynDeal implements Runnable {

	private IBusiOrderSyn iBusiOrderSyn = LocalContextFactory.getInstance().getBean("BusiOrderSynSvc", IBusiOrderSyn.class);

	private static Logger log = LoggerFactory.getLogger(BusiOrderSynDeal.class);
	
	@Override
	public void run() {

		//test
		String sBosstestString = "{\"ROOT\":{\"HEADER\":{\"DB_ID\":\"B1\",\"ROUTING\":{\"ROUTE_KEY\":\"12\",\"ROUTE_VALUE\":\"220690200022718998\"}},\"BODY\":{\"OPR_INFO\":{\"OP_CODE\":\"8020\",\"GROUP_ID\":\"355\",\"LOGIN_NO\":\"aa021A\"},\"BUSI_CODE\":\"ASYSNYDZF\",\"BUSI_INFO\":{\"ID_NO\":0,\"PHONE_NO\":\"99999999999\",\"PAY_SN\":10000119910680,\"CONTRACT_NO\":220140200091530493,\"LIST_SEND\":[{\"OP_CODE\":\"8020\",\"GROUP_ID\":\"355\",\"TRANSIN_LIST\":[{\"BEGIN_TIME\":\"20161014093103\",\"PAY_TYPE\":\"0\",\"CHANGEIN_FEE\":600000}],\"PAY_PATH\":\"11\",\"TRANSIN_FEE\":600000,\"BRAND_ID\":\"2210df\",\"REMARK\":\"一点支付220140200091530493给220690200022718998转账6000.00元\",\"DELAY_FAVOUR_RATE\":\"0.00\",\"PHONE_NO\":\"10510233232\",\"PAY_SN\":10000119910683,\"LOGIN_NO\":\"aa021A\",\"OP_TYPE\":\"SNYDZF\",\"IDNO_IN\":220690200022718997,\"PAY_METHOD\":\"0\",\"CONTRACT_NO\":220690200022718998,\"FOREIGN_SN\":\"10000119910680\"}]}}}}";
		MBean mb = new MBean(sBosstestString);
		if (mb.getHeaderStr(InterBusiConst.DATAODR_DBID)!=null)
			SessionContext.setDbLabel(mb.getHeaderStr(InterBusiConst.DATAODR_DBID));
		String busi_code = iBusiOrderSyn.getBusiCode(mb);
		try {
			iBusiOrderSyn.dealBusiOrderData(sBosstestString, busi_code, "");
		} catch (Exception e) {
			e.printStackTrace();
			
			Map<String, Object> err_map = new HashMap<String, Object>();
			err_map.put("ERR_CODE", "0001");
			err_map.put("ERR_MSG", "busiodrerror--errmsg="+e.toString());
			err_map.put("BUSI_CODE", busi_code);
			iBusiOrderSyn.inputBusiErr(mb, err_map);
		}
		
//		//Normal
//		final String topic = AppProperties.getConfigByMap("BUSIORDER_TOPIC");
//		final String addr = AppProperties.getConfigByMap("BUSIORDER_ADDR");
//		final String client = AppProperties.getConfigByMap("BUSIORDER_CLIENT");
//		final int processingTime = Integer.valueOf(AppProperties.getConfigByMap("PUB_TIMEOUT"));
//		final int sleep_second = Integer.valueOf(AppProperties.getConfigByMap("PUB_SLEEP"));
//		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
//				new PooledMessageContextFactory(addr, processingTime));
//		
//		String busi_code = "";
//		MBean mbean = null;
//		try   {
//			MessageContext context = pool.borrowObject(client);
//			String lastMessageId = null;
//			PullCode code = null;
//			String description = "业务工单-消费成功";
//			while (true) {
//				final Message message = context.fetch(topic, processingTime,
//						lastMessageId, code, description, false);
//				final ResultCode resultCode = ResultCode.valueOf(message
//						.getProperty(PropertyOption.RESULT_CODE));
//				if (resultCode == ResultCode.NO_MORE_MESSAGE) {
//					try {
//						log.debug("业务工单--消费主题["+topic+"],消费者["+client+"]，没有消息，休息 3s...");
//						TimeUnit.SECONDS.sleep(sleep_second);
//					} catch (final Exception e) {
//						e.printStackTrace();
//					}
//					lastMessageId = null;
//					code = null;
//					description = null;
//					continue;
//				}
//				//业务操作
//				try {
//					log.info("----------BUSIORDER BUSIORDERSyn BEGIN: ----------");
//					log.debug("the input TOPIC:"+message.getStringProperty(PropertyOption.TOPIC));
//					String content = message.getContentAsString();
//					mbean = new MBean(content);
//					if (mbean.getHeaderStr(InterBusiConst.DATAODR_DBID)!=null)
//						SessionContext.setDbLabel(mbean.getHeaderStr(InterBusiConst.DATAODR_DBID));
//					busi_code = iBusiOrderSyn.getBusiCode(mbean);
//					iBusiOrderSyn.dealBusiOrderData(content, busi_code);
//				} catch (Exception e) {
//					e.printStackTrace();
//					
//					Map<String, Object> err_map = new HashMap<String, Object>();
//					err_map.put("ERR_CODE", "0001");
//					err_map.put("ERR_MSG", "busiodrerror--errmsg="+e.toString());
//					err_map.put("BUSI_CODE", busi_code);
//					iBusiOrderSyn.inputBusiErr(mbean, err_map);
//				}
//					
//				lastMessageId = message.getId();
//				code = PullCode.COMMIT_AND_NEXT;
//			}
//		} catch (final Exception e) {
//			if (pool != null) {
//				//消息池如何销毁？？？
//			}
//			e.printStackTrace();
//		}//接消息OVER
		
	}
	
	  private static String getClassNameByInterName(String interfaceName)
	  {
	    String className = interfaceName.substring(0, interfaceName.length() - "Svc".length());
	    className = className.replaceAll("_", ".");
	    return className;
	  }
	  
}
