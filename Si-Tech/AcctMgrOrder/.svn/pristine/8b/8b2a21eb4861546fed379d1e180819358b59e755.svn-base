package com.sitech.acctmgr.app.msgodrsend;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.pool2.KeyedObjectPool;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.sitech.crmpd.idmm2.client.MessageContext;

public class MsgSendThread extends Thread {
	
	private MsgSend msgSend;  //LocalContextFactory.getInstance().getBean("MsgSendAppSvc", IMsgSend.class);
	private KeyedObjectPool<String, MessageContext> pool;
	private String dataSrc;
	private String topicId;
	private int threadSum;
	private int curthrdNum;
	
	private static Logger log = LoggerFactory.getLogger(MsgSendThread.class);

	@Override
	public void run() {
		
		log.debug("----Currentthreadid="+ Thread.currentThread().getId() + "--Thread running...");
		
		Map<String, Object> thrdInfoMap = new HashMap<String, Object>();
		thrdInfoMap.put("MID_POOL", getPool());
		thrdInfoMap.put("DATA_SRC", getDataSrc());
		thrdInfoMap.put("TOPIC_ID", getTopicId());
		thrdInfoMap.put("THRD_NUM", getThreadSum());
		thrdInfoMap.put("CURR_NUM", getCurthrdNum());
		while (true) {
			//无限循环处理数据
			try {
				
				//调用本地业务
				log.debug("----BUSIODR---调用本地业务 stt----");
				msgSend.dealMidMsgByThrd(thrdInfoMap);
				
				//sleep 1s
				log.debug("----BUSIODR---调用本地业务 end...sleep 1s...");
				try {
					Thread.sleep(1000L);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			} catch (Exception e) {
				e.printStackTrace();

				log.debug("消息处理异常，继续起对应主题线程处理消息...");
				//业务受理异常，继续起对应主题消息处理线程...
				continue;
			}
			
		}
	}
	
	/*************************private param***********************/
	public MsgSend getMsgSend() {
		return msgSend;
	}
	public void setMsgSend(MsgSend msgSend) {
		this.msgSend = msgSend;
	}

	public KeyedObjectPool<String, MessageContext> getPool() {
		return pool;
	}

	public void setPool(KeyedObjectPool<String, MessageContext> pool) {
		this.pool = pool;
	}

	public String getDataSrc() {
		return dataSrc;
	}

	public void setDataSrc(String dataSrc) {
		this.dataSrc = dataSrc;
	}

	public String getTopicId() {
		return topicId;
	}

	public void setTopicId(String topicId) {
		this.topicId = topicId;
	}

	public int getThreadSum() {
		return threadSum;
	}

	public void setThreadSum(int threadSum) {
		this.threadSum = threadSum;
	}

	public int getCurthrdNum() {
		return curthrdNum;
	}

	public void setCurthrdNum(int curthrdNum) {
		this.curthrdNum = curthrdNum;
	}
	
}
