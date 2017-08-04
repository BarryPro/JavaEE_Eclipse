package com.sitech.acctmgr.app.dataorder.configcache;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;

public class DataSynPool extends BaseBusi {

	private static int iStartNum = Integer.parseInt(
			AppProperties.getConfigByMap("DATASTART_NUM"));
	private final static String sAddr = AppProperties.getConfigByMap("DATAORDER_ADDR");
	private final static int processingTime = Integer.valueOf(AppProperties.getConfigByMap("PUB_PROCESSTIME"));
	//创建CONFIG对象
	private final static GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();
	//设置连接池大小
	static{
		CONFIG.setMaxTotalPerKey(iStartNum);
		//设置连接池返回的连接都经过检测可用
		CONFIG.setTestOnBorrow(true);
	}
	
	/*缓存数据工单消息中间件POOL*/
	private static ConcurrentHashMap dataSynPool = null;
	static {
		if (null == dataSynPool) {
			dataSynPool = new ConcurrentHashMap();
			setPool(dataSynPool);
			if (null == dataSynPool)
				System.out.print("-------getDataSynPool err---\n");
		}
	}
	
	/**
	 * 取得POOL
	 * @return
	 */
	public static KeyedObjectPool<String, MessageContext> getPool() {
		return (KeyedObjectPool<String, MessageContext>) dataSynPool.get("POOL");
	}
	
	/**
	 * 刷新POOL
	 */
	public static void refreshPool() {
		KeyedObjectPool<String, MessageContext> oldPool = 
				(KeyedObjectPool<String, MessageContext>) dataSynPool.get("POOL");
		if (oldPool != null) {
			oldPool.close();
		}
		setPool(dataSynPool);
	}
	
	/**
	 * Title 私有接口：获取POOL
	 * @param outCfgMap
	 */
	private static void setPool(ConcurrentHashMap outTabsConfigMap) {
		KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(sAddr, processingTime), CONFIG);
		outTabsConfigMap.put("POOL", pool);
		return ;
		
	}
	
}
