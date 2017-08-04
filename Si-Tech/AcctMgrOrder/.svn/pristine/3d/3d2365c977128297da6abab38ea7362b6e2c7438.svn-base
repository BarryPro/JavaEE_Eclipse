package com.sitech.acctmgr.app.common;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.app.common.quartz.rmi.ISchedulerServerFactory;
import com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServer;
import com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServerFactory;
import com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServerImpl;
import com.sitech.jcf.core.util.XMLFileContext;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;

/**
 *
 * <p>Title: spring容器手工启动类  </p>
 * <p>Description: 手工spring容器，承载后台应用程序  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class AppMain {
	private static Logger log = LoggerFactory.getLogger(AppMain.class);
	private static boolean isRunner = false;
	
	public static void main(String[] args) throws RemoteException, MalformedURLException {

		// 判断是否已经执行，如果执行，则退出，否则继续修改执行状态
		if (isRunner) {
			return;
		}
		isRunner = true;

		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext-app.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();

//        //启动RMI注册服务 20150515 用来做前台的一些功能，现在没用
//        LocateRegistry.createRegistry(1099);
//        ISchedulerServerFactory sf = new SchedulerServerFactory();
//        Naming.rebind("SchedulerServer", sf);
		
	}
}
