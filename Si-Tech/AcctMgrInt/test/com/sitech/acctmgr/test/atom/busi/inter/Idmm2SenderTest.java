package com.sitech.acctmgr.test.atom.busi.inter;

import java.io.IOException;
import java.util.Date;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

import org.junit.Test;
import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;

import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.acctmgrint.common.InterProperties;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;

public class Idmm2SenderTest extends BaseTestCase {


	//@Test
	//public void Idmm2Sender() {
	public static void main(String[] argv) {
		
		System.out.println("---------开始发送--------"+new Date());
		String client = "Pub101";
		/*
#KaiFa
ADDR=10.163.106.122:1234
#JiCheng
#ADDR=10.163.106.160:1234,10.163.106.161:1234,10.163.106.162:1234
#ZhunShengChan
#ADDR=10.162.200.211:4321,10.162.200.212:4321,10.162.200.213:4321
		 */
		String addr = "10.163.106.122:1234";
		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(addr, 6000));
		try {
			final MessageContext context = pool.borrowObject(client);
			String content = "--------20150724konglj---datasyn-----";
			final Message message = Message.create(content);// 如果是对象，需要先序列化，在消费者侧反序列化
			message.setProperty(PropertyOption.COMPRESS, true);// 是否压缩
			//message.setProperty(PropertyOption.GROUP, "13999999999");// id_no或者
			message.setProperty(PropertyOption.PRIORITY, 1000);// 1-1000
			final PropertyOption<String> MESSAGE_PART = PropertyOption.valueOf("msg_part");
			message.setProperty(MESSAGE_PART,  "01");
			final String id = context.send("T101DataSyn", message);
			System.out.println(id);
			context.commit(id);

			pool.returnObject(client, context);
			
			System.out.println("---------结束发送--------"+new Date());
		} catch (final Exception e) {
			e.printStackTrace();
		}

	}

}
