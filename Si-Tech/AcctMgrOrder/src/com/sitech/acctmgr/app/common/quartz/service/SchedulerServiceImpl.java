package com.sitech.acctmgr.app.common.quartz.service;

import java.text.ParseException;
import java.util.Date;
import java.util.UUID;

import org.quartz.CronExpression;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("schedulerService")
public class SchedulerServiceImpl implements SchedulerService {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
    private Scheduler scheduler;
    private JobDetail jobDetail;

    @Autowired
    public void setJobDetail(@Qualifier("jobDetail") JobDetail jobDetail) {
        this.jobDetail = jobDetail;
    }

    @Autowired
    public void setScheduler(@Qualifier("quartzScheduler") Scheduler scheduler) {
        this.scheduler = scheduler;
    }
    

    @Override
    public void schedule(String cronExpression) {
        schedule(jobDetail.getName(), cronExpression);
    }

    @Override
    public void schedule(String name, String cronExpression) {
        try {
            schedule(name, new CronExpression(cronExpression));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void schedule(CronExpression cronExpression) {
        schedule(jobDetail.getName(), cronExpression);
    }

    @Override
    public void schedule(String name, CronExpression cronExpression) {
        if (name == null || name.trim().equals("")) {
            name = UUID.randomUUID().toString();
        }

        try {
            scheduler.addJob(jobDetail, true);
            CronTrigger cronTrigger = new CronTrigger(name, jobDetail.getGroup(), jobDetail.getName(),jobDetail.getGroup());
            cronTrigger.setCronExpression(cronExpression);
            scheduler.scheduleJob(cronTrigger);
            scheduler.rescheduleJob(name, jobDetail.getGroup(), cronTrigger);
        } catch (SchedulerException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void schedule(Date startTime) {
        schedule(startTime, null);
    }

    @Override
    public void schedule(String name, Date startTime) {
        schedule(name, startTime, null);
    }

    @Override
    public void schedule(Date startTime, Date endTime) {
        schedule(startTime, endTime, 0);
    }

    @Override
    public void schedule(String name, Date startTime, Date endTime) {
        schedule(name, startTime, endTime, 0);
    }

    @Override
    public void schedule(Date startTime, Date endTime, int repeatCount) {
        schedule(null, startTime, endTime, 0);
    }

    @Override
    public void schedule(String name, Date startTime, Date endTime, int repeatCount) {
        schedule(name, startTime, endTime, 0, 0L);
    }

    @Override
    public void schedule(Date startTime, Date endTime, int repeatCount, long repeatInterval) {
        schedule(null, startTime, endTime, repeatCount, repeatInterval);
    }

    @Override
    public void schedule(String name, Date startTime, Date endTime, int repeatCount, long repeatInterval) {
        if (name == null || name.trim().equals("")) {
            name = UUID.randomUUID().toString();
        }

        try {
            scheduler.addJob(jobDetail, true);
            SimpleTrigger SimpleTrigger = new SimpleTrigger(name, jobDetail.getGroup(), jobDetail.getName(),
                    jobDetail.getGroup(), startTime, endTime, repeatCount, repeatInterval);
            scheduler.scheduleJob(SimpleTrigger);
            scheduler.rescheduleJob(name, jobDetail.getGroup(), SimpleTrigger);

        } catch (SchedulerException e) {
            throw new RuntimeException(e);
        }
    }

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.app.common.quartz.service.SchedulerService#getJobName()
	 */
	@Override
	public String getJobName() {
		return jobDetail.getName();
	}
}