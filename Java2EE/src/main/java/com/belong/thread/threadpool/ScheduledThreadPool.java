package com.belong.thread.threadpool;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @Description: <p>newScheduledThreadPool(5)</p>
 * 
 * 创建一个定长线程池，支持定时及周期性任务执行
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class ScheduledThreadPool {
	public static void main(String[] args) {
		ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);
		scheduledThreadPool.schedule(new Runnable() {
			public void run() {
				System.out.println("delay 3 seconds");
			}
		}, 3, TimeUnit.SECONDS);
	}
}
