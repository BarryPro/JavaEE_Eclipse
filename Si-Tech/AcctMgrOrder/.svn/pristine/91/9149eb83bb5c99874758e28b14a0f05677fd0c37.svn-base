package com.sitech.acctmgr.app.busiorder;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.app.busiorder.cachecfg.ProcNumAppCache;
import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcfx.dt.MBean;

public class PubBusiOdrDeal implements Runnable {

	private IBusiOrderSyn iBusiOrderSyn = LocalContextFactory.getInstance()
			.getBean("BusiOrderSynSvc", IBusiOrderSyn.class);

	private static Logger log = LoggerFactory.getLogger(PubBusiOdrDeal.class);
	
	@Override
	public void run() {
		//取静态Map信息，取得消息中间件主题相关信息
		String sKey = ProcNumAppCache.getKeyByVaNotZero();
		if (sKey == null) {
			log.info("--业务工单--进程已经全部启动，sKey=null,返回!----");
			return ;
		}
		int iValue = Integer.valueOf(ProcNumAppCache.getValueByKey(sKey).toString());
		log.info("----业务工单----sKey="+sKey+" iValue="+iValue+" ------");
		//Value值减1
		if (iValue == 1)
			ProcNumAppCache.delMapKey(sKey);
		else
			ProcNumAppCache.setMapValue(sKey, iValue - 1);
		
		try {
			//启动一个消费者，sKey对应主题配置
			runConsumer(sKey);
			
		} catch (Exception e) {
			log.info("-异常退出，继续启动该消费者-msg="+e.toString());
			e.printStackTrace();
		}
		
	}//run Function END
	
	/**
	 * 起一个对应的消费者
	 * @param busiCfg
	 */
	void runConsumer(String busiCfg) {

		String sTopic = AppProperties.getConfigByMap(busiCfg+"_ORDER_TOPIC");
		String sClient = AppProperties.getConfigByMap(busiCfg+"_ORDER_CLIENT");
		String sAddr = AppProperties.getConfigByMap("PUB_ORDER_ADDR");
		final int processingTime = Integer.valueOf(AppProperties.getConfigByMap("PUB_PROCESSTIME"));
		final int time_out = Integer.valueOf(AppProperties.getConfigByMap("PUB_TIMEOUT"));
		final int sleep_second = Integer.valueOf(AppProperties.getConfigByMap("PUB_SLEEP"));
		log.info("-----BUSIODR--topic=["+sTopic+"]-client=["+sClient+"]-addr=["+sAddr+"]----");

		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(sAddr, processingTime));
		String busi_code = "";
		MBean mbean = null;
		try   {
			MessageContext context = pool.borrowObject(sClient);
			String lastMessageId = null;
			PullCode code = null;
			String description = "业务工单-消费成功";
			while (true) {
				final Message message = context.fetch(sTopic, time_out,
						lastMessageId, code, description, false);
				final ResultCode resultCode = ResultCode.valueOf(message
						.getProperty(PropertyOption.RESULT_CODE));
				if (resultCode == ResultCode.NO_MORE_MESSAGE) {
					try {
						log.debug("业务工单--没有消息，休息 3s...");
						TimeUnit.SECONDS.sleep(sleep_second);
					} catch (final Exception e) {
						e.printStackTrace();
					}
					lastMessageId = null;
					code = null;
					description = null;
					continue;
				}
				//业务操作
				try {
					log.info("----------BUSIORDER BUSIORDERSyn BEGIN: ----------");
					log.debug("the input TOPIC:"+message.getStringProperty(PropertyOption.TOPIC));
					String content = message.getContentAsString();
					mbean = new MBean(content);
					if (mbean.getHeaderStr(InterBusiConst.DATAODR_DBID)!=null)
						SessionContext.setDbLabel(mbean.getHeaderStr(InterBusiConst.DATAODR_DBID));
					busi_code = iBusiOrderSyn.getBusiCode(mbean);
					iBusiOrderSyn.dealBusiOrderData(content, busi_code, "");
				} catch (Exception e) {
					e.printStackTrace();
					
					Map<String, Object> err_map = new HashMap<String, Object>();
					err_map.put("ERR_CODE", "0001");
					err_map.put("ERR_MSG", "busiodrerror--errmsg="+e.toString());
					err_map.put("BUSI_CODE", busi_code);
					iBusiOrderSyn.inputBusiErr(mbean, err_map);
				}
				
				lastMessageId = message.getId();
				code = PullCode.COMMIT_AND_NEXT;
			}
		} catch (final Exception e) {
			if (pool != null) {
				//消息池如何销毁
				pool.close();
			}
			e.printStackTrace();
		}//接消息OVER
	}

}
