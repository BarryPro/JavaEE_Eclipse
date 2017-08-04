package com.sitech.acctmgr.app.msgodrsend;

import java.util.Map;

public interface IMsgSend {
	
	//多线程，随机处理模式，查看当前接口表各个主题，按主题分线程处理
	//public boolean dealMidInfoMsg();取消使用
	//固定线程数，按BUSIID_NO%线程数=当前线程号处理。
	public void dealMidMsgByThrd(Map<String, Object> inThrdMap);
	
	public boolean dealErrOrder(Map<String, Object> inTopicMap, String file_flag);
	
	/**
	 * 读文件发送消息中间件方式
	 * 注意：文件每行格式【主题	内容】，分隔符：'\t'。
	 * @param in_map
	 * 			FILE_NAME 入参
	 * @return
	 */
	public int fileSendMsg(Map<String, Object> in_map);
}
