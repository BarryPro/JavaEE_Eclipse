package com.sitech.acctmgr.app.busiorder.cachecfg;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.sitech.acctmgr.app.common.AppProperties;
import org.apache.commons.lang.StringUtils;

public class ProcNumAppCache {

	/*缓存同步配置信息*/
	private static ConcurrentHashMap procNumMap = null;

	static {

		if (null == procNumMap) {
			procNumMap = new ConcurrentHashMap();
			getAllTAppConfig(procNumMap);
			if (null == procNumMap)
				System.out.print("----gettabconf end---tabsmap is null\n");
		}
	}
	
	public static void setMapValue(String sKey, Object object) {
		procNumMap.put(sKey, object);
	}
	public static void delMapKey(String sKey) {
		procNumMap.remove(sKey);
	}
	
	/**
	 * 取得第一个value>0的Key值
	 * @return
	 */
	public static String getKeyByVaNotZero() {
		Map<String, Object> tmpMap = procNumMap;
		String sKey = null;
		int iValue = 0;
		//循环Map信息
		for (Map.Entry<String, Object> entry : tmpMap.entrySet()) {
			sKey =  entry.getKey().toString();
			iValue = Integer.valueOf(entry.getValue().toString());
			if (iValue > 0)
				return sKey;
		}
		return null;
	}

	
	/**
	 * Title 取得对应业务标识的配置数据
	 * @param inBusiCode
	 * @return
	 */
	public static Object getValueByKey(String sKey) {
		
		return procNumMap.get(sKey);
	}
	
	/**
	 * Title 私有接口：从app.properties获取所有接口的配置放入静态Map变量
	 * Description 使用IBATIS缓存模式
	 * @param outCfgMap
	 */
	private static void getAllTAppConfig(ConcurrentHashMap outMap) {
		
		String[] sTmpStrs = null;
		
		//例如 PUB_BUSIODR_CFG=BUSI:4|MARK:4|BACH:4
		String sStr = AppProperties.getConfigByMap("PUB_BUSIODR_CFG");
//		String[] sArrayStrs = sStr.split("-");
        String[] sArrayStrs = StringUtils.split(sStr, "-");
		for (String str:sArrayStrs) {
//			sTmpStrs = str.split(":");
            sTmpStrs = StringUtils.split(str, ":");
			if (sTmpStrs.length == 2) {
				//存入Map
				outMap.put(sTmpStrs[0], sTmpStrs[1]);
				System.out.println("--busiordercache---key="+sTmpStrs[0]+"--value="+sTmpStrs[1]);
			}
			sTmpStrs = null;
		}
			
		return ;
		
	}

}
