package com.sitech.acctmgr.app.test;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;

import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.exception.NoSuchPropertyException;
import com.sitech.crmpd.idmm2.client.exception.OperationException;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;

/**
 * 提交消息
 * @author heihuwudi@gmail.com</br> Created By: 2015年4月3日 下午5:31:52
 */
public class PooledConsumer {
	/**
	 * 
	 * @param args
	 *            入参
	 * @throws Exception
	 * @throws
	 * @throws
	 */
	public static void main(String[] args) throws Exception {
		final String topic = "T109OrderDest";
		final String client_id = "Sub109Busi";
		final long processingTime = 60;
		String src_topic = null;
		int producer_retry = 0;
		int i = 0;
		MessageContext context = null;
		/*
		 * GenericKeyedObjectPoolConfig CONFIG = new
		 * GenericKeyedObjectPoolConfig();
		 * 
		 * CONFIG.setMaxTotalPerKey(20); CONFIG.setTestOnBorrow(true);
		 */

		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(
						"10.162.200.211:4321,10.162.200.212:4321,10.162.200.213:4321,10.162.200.220:4321,10.162.200.221:4321",
						60000));

		/*
		 * 压测：
		 * 
		 * 10.162.200.211:4321,10.162.200.212:4321,10.162.200.213:4321,10.162.200.220:4321,10.162.200.221:4321
		 * 
		 * 
		 * 功能测试：
		 * 
		 * 10.162.200.78:1234,10.162.200.79:1234,10.162.200.80:1234
		 * 
		 * 联调测试：
		 * 
		 * 10.163.106.122:1234
		 * 
		 * 集成测试： 10.163.106.160:1234,10.163.106.161:1234,10.163.106.162:1234
		 * 
		 * 准生产测试： 10.162.200.214:4621,10.162.200.220:4621,10.162.200.221:4621
		 * 
		 * 
		 * 北京开发： 172.21.3.100:4621,172.21.3.101:4621,172.21.3.98:4621
		 */
		//System.out.println("111");
		//System.out.println("before:" + System.currentTimeMillis() + "i=" + i);
		//while (true) {
			//System.out.println("b 11111" + i);
			try {
				context = pool.borrowObject(client_id);
				//String lastMessageId = null;
				String lastMessageId ="1451007362439::3213647::10.162.202.101:55778::47::1648";
				//PullCode code = null;
				PullCode code = PullCode.COMMIT;
				String description = "消费成功";
				//System.out.println("before fetch:" + System.currentTimeMillis()+ "i=" + i);
				//while(true) {
					Message message = context.fetch(topic, processingTime,lastMessageId, code, description, false);
					//final ResultCode resultCode = ResultCode.valueOf(message
					//		.getProperty(PropertyOption.RESULT_CODE));
					final ResultCode resultCode = ResultCode.OK;
					//System.out.println(resultCode);
					if (resultCode == ResultCode.NO_MORE_MESSAGE) {
						try {
							TimeUnit.SECONDS.sleep(3);
							System.out.println("sleep 3s");
						} catch (final InterruptedException e) {
							//continue;
						}
						lastMessageId = null;
						code = null;
						description = null;
						//continue;
					}

					//lastMessageId = message.getId();
					src_topic = message.getStringProperty(PropertyOption.TOPIC);
				    System.out.println("MessageId="+lastMessageId+">>>MESSAGE_CONTENT="+message.getContentAsString());
				
					
					try {
						producer_retry = message.getIntegerProperty(PropertyOption.PRODUCER_RETRY);
					} catch (NoSuchPropertyException e) {
						producer_retry = 0;
					}
					
					if (producer_retry>0)
					{
						//业务上判断是否重复消息，如果重复，直接提交
					}
					
					src_topic = message.getStringProperty(PropertyOption.TOPIC);
					//System.out.println(message.getContentAsString());
					//System.out.println("lastMessageId" + "=" + message.getId()
							//+ " ,producer_retry=" + producer_retry);
					// TimeUnit.SECONDS.sleep(10);
					// code = PullCode.COMMIT_AND_NEXT;
					//code = PullCode.COMMIT_AND_NEXT;
					code = PullCode.COMMIT;
					// TimeUnit.SECONDS.sleep(3);
					i++;

				//}
			} catch (final OperationException | IOException e) {
				e.printStackTrace();
			} finally {
				pool.returnObject(client_id, context);
			}

		//}
	}
}