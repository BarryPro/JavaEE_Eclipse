package com.sitech.acctmgr.app.common.quartz.rmi;

import java.io.Serializable;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.springframework.context.ApplicationContext;

import com.sitech.acctmgr.app.common.quartz.service.SchedulerService;
import com.sitech.acctmgr.app.common.quartz.service.SchedulerServiceImpl;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcfx.util.DateUtil;

/**
 * Created by zhangjp on 2015/4/10.
 */
public class SchedulerServerImpl extends UnicastRemoteObject implements SchedulerServer,Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Scheduler scheduler = null;
	
	public SchedulerServerImpl() throws RemoteException {
		super();
	}
	
	public SchedulerServerImpl(String schedulerName) throws RemoteException {
		super();
		scheduler = (Scheduler) LocalContextFactory.getInstance().getBean(schedulerName);
	}

	@Override
	public List<Map<String, Object>> qryJobList() throws RemoteException {
		List<Map<String, Object>> outMap = new ArrayList<Map<String, Object>>();
		try {
			String instanceName = scheduler.getSchedulerInstanceId();
			for (String triggerGroup : scheduler.getTriggerGroupNames()) {
				for (String triName : scheduler.getTriggerNames(triggerGroup)) {
					CronTrigger trigger = (CronTrigger) scheduler.getTrigger(
							triName, triggerGroup);
					
					Map<String, Object> jobMap = new HashMap<String, Object>();
					jobMap.put("TRIGGER_NAME", triName);
					jobMap.put("TRIGGER_GROUP", triggerGroup);
					jobMap.put("INSTANCE_NAME", instanceName);
					jobMap.put("JOB_GROUP_NAME", trigger.getJobGroup());
					jobMap.put("JOB_NAME", trigger.getJobName());
					jobMap.put("JOB_CRON", trigger.getCronExpression());
					JobDetail jobDetail = scheduler.getJobDetail(
							trigger.getJobName(), trigger.getJobGroup());
					jobMap.put("JOB_DESCRIPT", jobDetail.getDescription());
					String stateName = null;
					System.out.println("zhangjp test ："+scheduler.getTriggerState(triName, triggerGroup));
					switch (scheduler.getTriggerState(triName, triggerGroup)) {
					case Trigger.STATE_BLOCKED:
						stateName = "阻塞";
						break;
					case Trigger.STATE_COMPLETE:
						stateName = "完成";
						break;
					case Trigger.STATE_ERROR:
						stateName = "执行错误";
						break;
					case Trigger.STATE_NORMAL:
						stateName = "执行正常";
						break;
					case Trigger.STATE_PAUSED:
						stateName = "暂停";
						break;
					case Trigger.STATE_NONE:
						stateName = "不存在";
						break;
					}
					jobMap.put("JOB_STATE", stateName);
					jobMap.put("JOB_STRAT_TIME", DateUtil.format(trigger.getStartTime(), "yyyyMMdd HH:mm:ss"));
					jobMap.put("JOB_NEXT_TIME", DateUtil.format(trigger.getNextFireTime(), "yyyyMMdd HH:mm:ss"));
					jobMap.put("JOB_PRE_TIME", DateUtil.format(trigger.getPreviousFireTime(), "yyyyMMdd HH:mm:ss"));

					outMap.add(jobMap);
				}
			}

		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return outMap;
	}

	@Override
	public void startScheduler() throws RemoteException {
		try {
			scheduler.start();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void stopScheduler() throws RemoteException {
		try {
			scheduler.shutdown();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean startJob(String jobName, String jobGroup) throws RemoteException {
		try {
			scheduler.resumeJob(jobName, jobGroup);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean pauseJob(String jobName, String jobGroup) throws RemoteException {
		try {
			scheduler.pauseJob(jobName, jobGroup);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean isStarted() throws RemoteException {

		try {
			return scheduler.isStarted();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateTriggerByName(String Name, String Group, String cronExpression) throws RemoteException {
		try {
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(Name,
					Group);
			trigger.setCronExpression(cronExpression);
			scheduler.rescheduleJob(Name, Group, trigger);
		} catch (SchedulerException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServer#qryJobListUnTrigger
	 * ()
	 */
	@Override
	public List<Map<String, String>> qryJobListUnTrigger() throws RemoteException {
		// 从Jcf框架中拿到applicationContext
		ApplicationContext applicationContext = LocalContextFactory
				.getInstance().getSpringWebContext();
		// 根据Bean类类型获取到所有注册的Bean名称
		// 然后根据Bean取到注入的JobName，压入Map中
		String[] ssBeanId = applicationContext
				.getBeanNamesForType(SchedulerServiceImpl.class);
		Map<String, String> ssBeanMap = new HashMap<String, String>();
		for (String ssBeanName : ssBeanId) {
			SchedulerService ss = (SchedulerService) applicationContext
					.getBean(ssBeanName);
			ssBeanMap.put(ss.getJobName(), ssBeanName);
		}
		// 循环查询到当前已配置trigger的Job列表，从上面的所有的job中剔除掉
		for (Map<String, Object> jobMap : this.qryJobList()) {
			ssBeanMap.remove(jobMap.get("JOB_NAME"));
		}
		// 把Map转成List传出去
		List<Map<String, String>> outMap = new ArrayList<Map<String, String>>();
		for (String jobName : ssBeanMap.keySet()) {
			Map<String, String> sBeanMap = new HashMap<String, String>();
			sBeanMap.put("JOB_NAME", jobName);
			sBeanMap.put("BEAN_NAME", ssBeanMap.get(jobName));
			outMap.add(sBeanMap);
		}
		return outMap;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServer#schedule(java
	 * .lang.String, java.lang.String, org.quartz.CronExpression)
	 */
	@Override
	public void schedule(String BeanName, String cronExpression) throws RemoteException {
		SchedulerService ss = (SchedulerService) LocalContextFactory
				.getInstance().getBean(BeanName);
		ss.schedule(cronExpression);
	}

}
