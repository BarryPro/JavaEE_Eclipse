package com.sitech.acctmgr.test.atom.busi.inter;

import java.util.concurrent.TimeUnit;

import org.junit.Test;

import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.acctmgrint.common.InterProperties;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;

import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;


public class Idmm2ConsumerTest extends BaseTestCase {

	@Test
	// public void Idmm2Consumer() {
	public static void main(String[] args) {
		final int processingTime = 6000;
		String client = "Pub101";
		final String topic = "T101DataSyn";
		String addr = InterProperties.getConfigByMap("ADDR");
		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(addr, processingTime));
		try {
			MessageContext context = pool.borrowObject(client);
			String lastMessageId = null;
			PullCode code = null;
			String description = "消费成功";
			while (true) {
				final Message message = context.fetch(topic, processingTime,
						lastMessageId, code, description, false);
				final ResultCode resultCode = ResultCode.valueOf(message
						.getProperty(PropertyOption.RESULT_CODE));
				if (resultCode == ResultCode.NO_MORE_MESSAGE) {
					try {
						System.out.println("消费主题["+topic+"],消费者["+client+"]，没有消息，休息 3s...");
						TimeUnit.SECONDS.sleep(3);
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
					System.out.println(message.getContentAsString());
				} catch (Exception e) {
					code = PullCode.ROLLBACK_AND_NEXT;
				}
				
				lastMessageId = message.getId();
				code = PullCode.COMMIT_AND_NEXT;
			}
		} catch (final Exception e) {
			e.printStackTrace();
		}
		
	}

}
