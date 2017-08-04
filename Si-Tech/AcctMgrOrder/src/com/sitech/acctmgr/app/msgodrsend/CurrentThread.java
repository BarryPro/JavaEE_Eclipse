package com.sitech.acctmgr.app.msgodrsend;

import java.util.HashMap;
import java.util.Map;

public class CurrentThread {

	/**
	 * param:
	 * DATA_SRC:FWKT\BUSI
	 * TOPIC_ID:T101Smsp
	 * SUFFIX:01\02\03
	 * THRD_NUM:CPU*2
	 * CURR_NUM:1,2
	 */
	static Map<String, Object> thrdInfoMap = new HashMap<String, Object>();
	
	
	public static Map<String, Object> getThrdInfoMap() {
		return thrdInfoMap;
	}

	public static synchronized void setThrdInfoMap(String inParaStr, Object oValue) {
		thrdInfoMap.put(inParaStr, oValue);
	}
	
	public static Object getThrdInfoValue(String inKeySuffix) {
		return thrdInfoMap.get(inKeySuffix);
	}

	/**********************************************/
	//线程状态 ，弃用
	static Map<Integer, Boolean> threadMap = new HashMap<Integer, Boolean>();

	public static Map<Integer, Boolean> getThreadMap() {
		return threadMap;
	}
	
	public static Boolean getThrdValue(int iKeySuffix) {
		return threadMap.get(iKeySuffix);
	}

	public static synchronized void setThreadMap(int threadNum, Boolean threadStatus) {
		threadMap.put(threadNum, threadStatus);
	}
	
}
