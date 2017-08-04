package com.sitech.acctmgr.app.common.quartz.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;

/**
 * Created by zhangjp on 2015/4/10.
 * 设计：帐管这次使用的quartz，job和trigger是一对一的配置，jobname=triggerName
 * 注：接口中的方法必须显式抛出RemoteException
 */
public interface SchedulerServer extends Remote {
	
	/**
	 * 功能：配置某个job 
	 */
	public void schedule(String BeanName, String cronExpression) throws RemoteException;
	
	/**
	 * 功能：列出当前服务器的未配置trigger的任务列表
	 */
	public List<Map<String,String>> qryJobListUnTrigger() throws RemoteException;

    /**
     * 功能：列出当前服务端的job列表
     */
    public List<Map<String,Object>> qryJobList() throws RemoteException;

    /**
     * 功能：修改当前服务端的trigger的触发时间
     */
    public boolean updateTriggerByName(String Name,String Group,String cronExpression) throws RemoteException;

    /**
     * 功能：判断服务器Scheduler的状态
     */
    public boolean isStarted() throws RemoteException;
    
    /**
     * 功能：启动服务器Scheduler
     */
    public void startScheduler() throws RemoteException;

    /**
     * 功能：停掉服务器Scheduler
     */
    public void stopScheduler() throws RemoteException;

    /**
     * 功能：启动某个Job
     */
    public boolean startJob(String jobName,String jobGroup) throws RemoteException;

    /**
     * 功能：暂定某个Job
     */
    public boolean pauseJob(String jobName,String jobGroup) throws RemoteException;
}
