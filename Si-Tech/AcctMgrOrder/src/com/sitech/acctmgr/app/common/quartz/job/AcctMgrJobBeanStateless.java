package com.sitech.acctmgr.app.common.quartz.job;

import java.lang.reflect.Method;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * Created by zhangjp on 2015/4/8.
 * 注：不实现StatefulJob，job实例变成Stateless（无状态），job任务可以并发
 */
public class AcctMgrJobBeanStateless extends QuartzJobBean {

    private String targetObject;
    private String targetMethod;

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

}
