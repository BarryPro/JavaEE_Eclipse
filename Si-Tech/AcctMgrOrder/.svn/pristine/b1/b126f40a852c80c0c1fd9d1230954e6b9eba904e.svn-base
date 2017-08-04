package com.sitech.acctmgr.app.common.quartz.job;

import java.lang.reflect.Method;

import org.quartz.InterruptableJob;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;
import org.quartz.UnableToInterruptJobException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * Created by zhangjp on 2015/4/8.
 * 注：实现StatefulJob，job实例变成Stateful，job任务只能串行执行，不能并发
 */
public class AcctMgrJobBean extends QuartzJobBean implements StatefulJob, InterruptableJob {

    private String targetObject;
    private String targetMethod;
    private boolean _interrupted = false;

    @Override
    protected void executeInternal(JobExecutionContext jobexecutioncontext)
            throws JobExecutionException {
        try {
            ApplicationContext ctx = (ApplicationContext) jobexecutioncontext.getScheduler().getContext().get("applicationContext");
            Object otargetObject = ctx.getBean(targetObject);

            Method m = null;
            try {
                m = otargetObject.getClass().getMethod(targetMethod,
                        new Class[]{});

                m.invoke(otargetObject, new Object[]{});
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            throw new JobExecutionException(e);
        } finally {

        }

    }

    /**
     * @param targetObject the targetObject to set
     */
    public void setTargetObject(String targetObject) {
        this.targetObject = targetObject;
    }

    /**
     * @param targetMethod the targetMethod to set
     */
    public void setTargetMethod(String targetMethod) {
        this.targetMethod = targetMethod;
    }

	/* (non-Javadoc)
	 * @see org.quartz.InterruptableJob#interrupt()
	 */
	@Override
	public void interrupt() throws UnableToInterruptJobException {
		//通过该标识停掉应用，用反射的情况下好像停不掉，想想看看其他办法
		_interrupted = true;
	}

}
