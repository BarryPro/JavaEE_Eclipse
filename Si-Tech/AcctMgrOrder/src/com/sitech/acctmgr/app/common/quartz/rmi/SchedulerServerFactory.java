package com.sitech.acctmgr.app.common.quartz.rmi;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.List;

import com.sitech.jcf.context.LocalContextFactory;

/**
 * Created by zhangjp on 2015/7/9.
 * 设计：供RMI客户端调用的工厂方法
 */
public class SchedulerServerFactory extends UnicastRemoteObject implements ISchedulerServerFactory {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @throws RemoteException
	 */
	public SchedulerServerFactory() throws RemoteException {
		super();
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.app.common.quartz.rmi.ISchedulerServerFactory#getSchedulerServer(java.lang.String)
	 */
	@Override
	public SchedulerServer getSchedulerServer(String SchedulerServerName) throws RemoteException {
		return new SchedulerServerImpl(SchedulerServerName);
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.app.common.quartz.rmi.ISchedulerServerFactory#getSchedulerServerNames()
	 */
	@Override
	public String[] getSchedulerServerNames() throws RemoteException {
		return LocalContextFactory.getInstance().getSpringWebContext().getBeanNamesForType(org.springframework.scheduling.quartz.SchedulerFactoryBean.class);
	}
	
}
