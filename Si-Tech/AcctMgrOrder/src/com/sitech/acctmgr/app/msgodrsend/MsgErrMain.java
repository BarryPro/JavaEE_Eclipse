package com.sitech.acctmgr.app.msgodrsend;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.util.XMLFileContext;

public class MsgErrMain {
	
	/**
	 * 名称:消息发送异常工单处理
	 * 使用:./bin 数据库标签[A1/B1] 0 create_accept 对指定流水的工单重发 
	 *     ./bin 数据库标签[A1/B1] 1 0000   提所有err_code=0000的工单，重发
	 *     ./bin 数据库标签[A1/B1] 2 5 5分钟内的单子重发
	 * 注意：单次最大处理200条数据；处理成功入HIS表，删除ERR表数据，失败不处理
	 * 日期:2015/09/05
	 */
	public static void main(String[] args) {
		
		System.err.println("args.length="+args.length+"  "+args[0]);
		if (args.length < 3) {
			System.err.println("|-----------------------------------------------|");
			System.err.println("|用例:./MsgErrMain 数据库标签[A1/B1] 0 create_accept 对指定流水的工单重发");
			System.err.println("|用例:./MsgErrMain 数据库标签[A1/B1] 1 0000                              提所有err_code=0000的工单，重发");
			System.err.println("|用例:./MsgErrMain 数据库标签[A1/B1] 2 5             5分钟内的单子重发（不包含信控停机C200工单）");
			System.err.println("|用例:./MsgErrMain 数据库标签[A1/B1] 3 reSend.txt    文件每行格式：【主题名称	内容】，'\t'分割开，重发该文件中信息");
			System.err.println("|===============================================|");
			System.err.println("|注意：单次最大处理200条数据（除文件方式外）；处理成功入HIS表，删除ERR表数据，失败不处理。");
			System.err.println("|-----------------------------------------------|");
			return ;
		}
		String datab_id = args[0];
		String deal_flg = args[1];
		String param_3 = args[2];

		//取得消息中间件POOL
		KeyedObjectPool<String, MessageContext> pool_mid = getMidPool();
				
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();
		
		//切换数据库标签
		SessionContext.setDbLabel(datab_id);
		
		IMsgSend iMsgSend = LocalContextFactory.getInstance()
				.getBean("MsgSendSvc", IMsgSend.class);

		try {
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("DEAL_FLG", deal_flg);
			inMap.put("DEAL_VAL", param_3);
			//消息池入参
			inMap.put("POOL_MID", pool_mid);
			//开始处理
			iMsgSend.dealErrOrder(inMap, "N");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool_mid.close();
		}
	}
	
	private static KeyedObjectPool<String, MessageContext> getMidPool() {
		//定义消息中间件池大小,若配置线程数THREAD_NUM大于默认数，则设置
		int process_time = Integer.valueOf(AppProperties.getConfigByMap("PUB_PROCESSTIME"));
		KeyedObjectPool<String, MessageContext> pool =
				 new GenericKeyedObjectPool<String, MessageContext>(
					new PooledMessageContextFactory(AppProperties.getConfigByMap("PUB_ADDR"),
							process_time));

		return pool;
	}
	
}
