package com.sitech.acctmgr.app.msgodrsend;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.RejectedExecutionException;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;

public class MsgSendJob implements Serializable {
	
	private static final GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();
	
	private static Logger log = LoggerFactory.getLogger(MsgSendJob.class);
	private static boolean isRunner = false;
	private static ExecutorService serviceList; 
	
	public static void dealMessage() {
		// 判断是否已经执行，如果执行，则退出，否则继续修改执行状态
		if (isRunner) {
			log.debug("The Process isRunner, MsgSendJob dealMessage.");
			return;
		}
		isRunner = true;
		log.debug("msgsend begin...");

		//测试文件句柄数
		//RunCommand runcmd = new RunCommand();
		//句柄数大于100进程号命令
		//String cmd = "lsof -n|awk '{print $2}'|sort|uniq -c|sort  | awk '{if($1>100)print}'";
		
		int iThrdNum = 0;
		int iCpuNum = 0;
		String sDataSrc = "";
		String sTopicId = "";
		//String sSuffix = "";
		try {
			List<Map<String, Object>> listCfgMaps = 
					MsgCfgCache.getTabConfigData(InterBusiConst.MSGSND_TABNAME);
			//循环处理  listCfgMaps 起线程
			for (Map<String, Object> tmpCfgMap:listCfgMaps) {
				//得到配置
				log.debug("------------msgsend cfg----tmpCfgMap="+tmpCfgMap.toString());
				iThrdNum = Integer.valueOf(tmpCfgMap.get("THREAD_NUM").toString());
				sDataSrc = tmpCfgMap.get("DATA_SOURCE").toString();
				sTopicId = tmpCfgMap.get("TOPIC_ID").toString();

				/*
				//处理线程数为 CPU 个数的整数倍
				//假设CPU=2,若iThrdNum=2,则实际线程数为2;若iThrdNum=3,则实际线程数为4.
				iCpuNum = Runtime.getRuntime().availableProcessors();
				//注释起，配置时注意便可
				iThrdNum = (iThrdNum % iCpuNum > 0) ? (iThrdNum/iCpuNum+1)*iCpuNum : iThrdNum;
				*/
				log.debug("---data_src="+sDataSrc+" --iCpuNum="+iCpuNum+"--实际线程数为："+iThrdNum);
				
				//定义消息中间件池大小,若配置线程数THREAD_NUM大于默认数，则设置
				int process_time = Integer.valueOf(AppProperties.getConfigByMap("PUB_PROCESSTIME"));
				KeyedObjectPool<String, MessageContext> pool = null;
				if (iThrdNum > InterBusiConst.DEFLT_THRD_NUM) {
					CONFIG.setMaxTotalPerKey(iThrdNum);
					CONFIG.setTestOnBorrow(true);
					pool = new GenericKeyedObjectPool<String, MessageContext>(
							new PooledMessageContextFactory(AppProperties.getConfigByMap("PUB_ADDR"),
									process_time), CONFIG);
				} else {
					pool = new GenericKeyedObjectPool<String, MessageContext>(
							new PooledMessageContextFactory(AppProperties.getConfigByMap("PUB_ADDR"),
									process_time));
				}
				
				//定义线程池
				serviceList = Executors.newFixedThreadPool(iThrdNum);
				
				for (int i = 0; i < iThrdNum; i++) {
					log.debug("----------iMaxThreadNum="+iThrdNum+"; i="+i);
					//设置当前线程号
					//20150713 修改静态Map为类参数赋值
					//CurrentThread 传递当前线程信息给 msgThread
					//非Svc注册服务，不能使用IBATIS操作数据，使用JDBC自取连接
					MsgSendThread msgThread = LocalContextFactory.getInstance()
							.getBean("MsgSendThrd", MsgSendThread.class);
					msgThread.setPool(pool);
					msgThread.setDataSrc(sDataSrc);
					msgThread.setTopicId(sTopicId);
					msgThread.setThreadSum(iThrdNum);
					msgThread.setCurthrdNum(i);

					//起多进程处理解析
					serviceList.execute(msgThread);
					
					//睡眠1s
					Thread.sleep(1000);
				}
				log.debug("-------sDataSrc="+sDataSrc+"-END-----");
				
			}
		} catch (RejectedExecutionException e) {
			log.debug("-----msgsend Execution: 线程出问题了,"+e.getMessage());
			e.printStackTrace();
		} catch (Exception ex) {
			log.debug("-----msgsend Exception: CATCH异常," + ex.getMessage());
			ex.printStackTrace();
		} finally {
			//关闭线程池
			serviceList.shutdown();
			log.info("-----msgsend finally: 关闭线程池,禁止添加新任务...");
		}
	}
	
}
//			//线程池大小=当前系统的CPU 数目*池个数
//			final int iMaxThreadNum=Runtime.getRuntime().availableProcessors()*2;
//			//定义线程池
//			//final ExecutorService serviceList=Executors.newCachedThreadPool();
//			serviceList = Executors.newFixedThreadPool(iMaxThreadNum);
//			
//			for(int i=0; i<iMaxThreadNum; i++)
//			{
//				log.debug("zhangjp test: iMaxThreadNum="+String.valueOf(iMaxThreadNum)+"; i="+String.valueOf(i));
//				//起多进程处理解析
//				serviceList.execute(msgThread);
//				log.debug("-----konglj test--execute succ---");
//			}
//			//等待10s,线程
//			Thread.sleep(10000);
//			log.debug("-------serviceList.isTerminated()------"+serviceList.isTerminated());

			//等待任务完成
//			int iTrdNum = 0;
//			while(!serviceList.isTerminated()) {
//				log.debug("-----TRDList is Terminated--"
//						+String.valueOf(((ThreadPoolExecutor)serviceList).getActiveCount()));
//				//如果进程有掉的，则重新起
//				while(((ThreadPoolExecutor)serviceList).getActiveCount() < iMaxThreadNum){
//					log.debug("-----TRDList is Terminated. restart it...ActiveCount="+((ThreadPoolExecutor)serviceList).getActiveCount());					
//					iTrdNum = 0;
//					Iterator<Entry<Integer, Boolean>> iterator = CurrentThread.getThreadMap().entrySet().iterator();
//					log.debug("-----TRDList is Terminated. iterator.hasnext="+iterator.hasNext());	
//					while (iterator.hasNext()) {
//						
//						log.debug("-----iterator.hasNext...");
//						Map.Entry<Integer, Boolean> entry = iterator.next();//(Map.Entry<Integer, Boolean>) 
//						if (entry.getValue() == false)
//						iTrdNum = entry.getKey();
//						log.debug("-----iterator.getkey="+iTrdNum);
//						//重启线程
//						serviceList.execute(msgThread);
//					}
//					log.debug("---------thread.sleep-1s------");
//					//休息1秒
//					Thread.sleep(1000);
//
//				}
//				log.debug("---------thread.sleep(30s)-----");
//				//休息30秒
//				Thread.sleep(30000);
//			}

