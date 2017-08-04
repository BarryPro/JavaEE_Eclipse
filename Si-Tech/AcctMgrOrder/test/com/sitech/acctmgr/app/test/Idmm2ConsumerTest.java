package com.sitech.acctmgr.app.test;

import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.junit.Test;

import com.sitech.acctmgr.common.InterProperties;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;

import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;


public class Idmm2ConsumerTest {
/*
##BaseOrderTask
BASELOGIN_TOPIC=TSynLoginNoDest
BASELOGIN_CLIENT=Sub109SynLoginNo

BASEGROUP_TOPIC=TSynGroupMsgDest
BASEGROUP_CLIENT=Sub109SynGroupMsg

BASEFUNC_TOPIC=TSynFuncDictDest
BASEFUNC_CLIENT=Sub109SynFuncDict

BASEGRPRE_TOPIC=TSynGroupRelDest
BASEGRPRE_CLIENT=Sub109SynGroupRel
PRODPRC_TOPIC=T104DataSynDest
PRODPRC_CLIENT=Sub109PdDataSyn

##BaseOrderTask
BASELOGIN_TOPIC=TSynLoginNoDest
BASELOGIN_CLIENT=Sub109SynLoginNo

BASEGROUP_TOPIC=TSynGroupMsgDest
BASEGROUP_CLIENT=Sub109SynGroupMsg

BASEFUNC_TOPIC=TSynFuncDictDest
BASEFUNC_CLIENT=Sub109SynFuncDict

BASEGRPRE_TOPIC=TSynGroupRelDest
BASEGRPRE_CLIENT=Sub109SynGroupRel

PRODPRC_TOPIC=T104DataSynDest
PRODPRC_CLIENT=Sub109PdDataSyn

### CGCG 
CGCG_ORDER_CLIENT=Sub109CG
CGCG_ORDER_TOPIC=TSendCustGroup
*/
	public static void main(String[] args) {
		final int processingTime = 60000;
		String client = "Sub109DataSyn";
		final String topic = "T101DataSynDest";
		//String client = "Sub109Busi";
		//final String topic = "T109OrderDest";
		String addr = "10.149.85.32:2185,10.149.85.33:2185,10.149.85.34:2185";
		GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();
		//设置连接池大小
        CONFIG.setMaxTotalPerKey(10);
        //设置连接池返回的连接都经过检测可用
        CONFIG.setTestOnBorrow(true);
		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(addr, processingTime),CONFIG);
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
					System.out.println("接收消息:"+message.getContentAsString());
				} catch (Exception e) {
					code = PullCode.ROLLBACK_AND_NEXT;
				}
				
				lastMessageId = message.getId();
				System.out.println("接收消息ID:"+lastMessageId);
				code = PullCode.COMMIT_AND_NEXT;
			}
		} catch (final Exception e) {
			e.printStackTrace();
		}
		pool.close();
	}

}