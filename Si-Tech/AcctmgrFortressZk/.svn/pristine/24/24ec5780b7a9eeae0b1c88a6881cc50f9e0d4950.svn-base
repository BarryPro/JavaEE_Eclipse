package com.sitech.acctmgr.app.common.quartz.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface ISchedulerServerFactory extends Remote {

	public abstract SchedulerServer getSchedulerServer (
			String SchedulerServerName) throws RemoteException;

	
	public abstract String[] getSchedulerServerNames() throws RemoteException;
	
}