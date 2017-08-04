package com.sitech.acctmgr.app.dataorder;

import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.dataorder.DataOrderDeal;
import com.sitech.acctmgr.app.dataorder.IDataOrder;
import com.sitech.acctmgr.app.dataorder.configcache.DataSynPool;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcfx.dt.MBean;

public class DataOrderDeal implements Runnable {

	private IDataOrder iDataOrder = LocalContextFactory.getInstance()
			.getBean("DataOrderSvc", IDataOrder.class);

	private static Logger log = LoggerFactory.getLogger(DataOrderDeal.class);
	
	private static int iStartNum = Integer.parseInt(
			AppProperties.getConfigByMap("DATASTART_NUM"));
	private static int iStartRealNum = 0;
	
	//设置消息中间件参数
	private final static String sTopic = AppProperties.getConfigByMap("DATAORDER_TOPIC");
	private final static String sClient = AppProperties.getConfigByMap("DATAORDER_CLIENT");
	private final static int time_out = Integer.valueOf(AppProperties.getConfigByMap("PUB_TIMEOUT"));
	private final static int sleep_second = Integer.valueOf(AppProperties.getConfigByMap("PUB_SLEEP"));
	
	private final static String sAddr = AppProperties.getConfigByMap("DATAORDER_ADDR");
	private final static int processingTime = Integer.valueOf(AppProperties.getConfigByMap("PUB_PROCESSTIME"));
	/*//创建CONFIG对象
	private final static GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();
	//设置连接池大小
	static{
		CONFIG.setMaxTotalPerKey(iStartNum);
		//设置连接池返回的连接都经过检测可用
		CONFIG.setTestOnBorrow(true);
	}
	private final static KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
			new PooledMessageContextFactory(sAddr, processingTime), CONFIG);*/
	
	@Override
	public void run() {
		
		log.debug("---------- test DATAORDER dataOrderSyn begin: ----------");
		String inJsonStr = "{\"ROOT\":{\"HEADER\":{\"DB_ID\":\"B1\",\"ROUTING\":{\"ROUTE_KEY\":\"12\",\"ROUTE_VALUE\":\"220690200022718998\"}},\"BODY\":{\"OPR_INFO\":{\"OP_CODE\":\"8020\",\"GROUP_ID\":\"355\",\"LOGIN_NO\":\"aa021A\"},\"BUSI_CODE\":\"ASYSNYDZF\",\"BUSI_INFO\":{\"ID_NO\":0,\"PHONE_NO\":\"99999999999\",\"PAY_SN\":10000119910680,\"CONTRACT_NO\":220140200091530493,\"LIST_SEND\":[{\"OP_CODE\":\"8020\",\"GROUP_ID\":\"355\",\"TRANSIN_LIST\":[{\"BEGIN_TIME\":\"20161014093103\",\"PAY_TYPE\":\"0\",\"CHANGEIN_FEE\":600000}],\"PAY_PATH\":\"11\",\"TRANSIN_FEE\":600000,\"BRAND_ID\":\"2210df\",\"REMARK\":\"一点支付220140200091530493给220690200022718998转账6000.00元\",\"DELAY_FAVOUR_RATE\":\"0.00\",\"PHONE_NO\":\"10510233232\",\"PAY_SN\":10000119910683,\"LOGIN_NO\":\"aa021A\",\"OP_TYPE\":\"SNYDZF\",\"IDNO_IN\":220690200022718997,\"PAY_METHOD\":\"0\",\"CONTRACT_NO\":220690200022718998,\"FOREIGN_SN\":\"10000119910680\"}]}}}}";
		MBean mb = null;
		try {
			mb = new MBean(inJsonStr);
			//设置A,B库
			String sDbLabel = mb.getHeaderStr(InterBusiConst.DATAODR_DBID);
			SessionContext.setDbLabel(sDbLabel);
			
			if (iDataOrder.dataOrderSyn(mb, "") == false)
				System.out.println("-------返回False 报错！已计入历史。------");
			
		} catch (Exception e) {
			//记录错误
			System.out.println("-test-DEAL:throw Exception.e="+e.getMessage());
			e.printStackTrace();
			
			Map<String, Object> opr_info = iDataOrder.getOrderAccept(mb);
			iDataOrder.inputErrOrderDeal(mb, opr_info, e.getMessage());
		}
		log.debug("---------- test DataOrder dataOrderSyn END! ----------");
		
//		//Quartz中concurrent值须为true,否则仍只有一个
//		if (iStartRealNum >= iStartNum) {
//			return;//如果启动进程数大于配置数，直接退出
//		}
//		log.debug("----DATASYN--iStartRealNum="+iStartRealNum);
//		
//		//从静态Map取得Pool
//		KeyedObjectPool<String, MessageContext> pool = DataSynPool.getPool();
//		MessageContext context = null;
//		try {
//			//启动次数加1
//			iStartRealNum ++;
//			
//			//启动消息中间件
//			context = pool.borrowObject(sClient);
//			String lastMessageId = null;
//			PullCode code = null;
//			String description = "业务工单-消费成功";
//			while (true) {
//				final Message message = context.fetch(sTopic, time_out,
//						lastMessageId, code, description, false);
//				final ResultCode resultCode = ResultCode.valueOf(message
//						.getProperty(PropertyOption.RESULT_CODE));
//				if (resultCode == ResultCode.NO_MORE_MESSAGE) {
//					try {
//						log.debug("数据工单--没有消息，休息 3s...");
//						
//						TimeUnit.SECONDS.sleep(sleep_second);
//						
//					} catch (final Exception e) {
//						e.printStackTrace();
//					}
//					lastMessageId = null;
//					code = null;
//					description = null;
//					continue;
//				}
//				//业务操作
//				String content = "";
//				MBean mBean = null;
//				try {
//					content = message.getContentAsString();
//					//content = message.getContentAsUtf8String();
//					code = PullCode.COMMIT_AND_NEXT;
//					lastMessageId = message.getId();
//
//					//转MBean，失败不做任何操作，直接continue...
//					try {
//						mBean = new MBean(content);
//					} catch (Exception e) {
//						log.error("This Content can't TRANSFER to MBean.content="+content);
//						continue;
//					}
//					
//					log.debug("----------DATAORDER dataOrderSyn begin: ----------");
//					log.debug("the param input JSON file:["+content+"]");
//					//设置A,B库
//					String sDbLabel = mBean.getHeaderStr(InterBusiConst.DATAODR_DBID);
//					SessionContext.setDbLabel(sDbLabel);
//					if (iDataOrder.dataOrderSyn(mBean, "") == false) {
//						log.debug("return false,please check!已记入历史，请查询~~~");
//					}
//					log.debug("----------DataOrder dataOrderSyn  END! ----------");
//				} catch (Exception e) {
//					//其他操作
//					//插入错误历史表
//					e.printStackTrace();
//					Map<String, Object> opr_info = iDataOrder.getOrderAccept(mBean);
//					iDataOrder.inputErrOrderDeal(mBean, opr_info, "errmsg="+e.getMessage());					
//					
//				}
//				
//			}//while END
//		} catch (final Exception e) {
//			log.debug("启动消息中间件报错，errmsg="+e.getMessage());
//			if (pool != null) {
//				//自动刷新
//				iStartRealNum --;//启动次数减1
//				log.debug("启动线程数自减1.当前个数="+iStartRealNum);
//				
//				if (iStartRealNum == 0) {
//					DataSynPool.refreshPool();
//				}
//				try {
//					pool.returnObject(sClient, context);
//					log.debug("无法连接消息中间件，returnObject...");
//				} catch (Exception e1) {
//					e1.printStackTrace();
//				}
//				
//			}
//			e.printStackTrace();
//		}//接消息OVER
		/////////////////////////////////////////////////////////////////////////////

	}

}
