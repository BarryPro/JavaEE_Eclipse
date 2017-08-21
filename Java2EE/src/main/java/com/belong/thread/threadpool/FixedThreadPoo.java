package com.belong.thread.threadpool;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @Description: <p>newFixedThreadPool(3)</p>
 * 
 * 创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class FixedThreadPoo {
	public static void main(String[] args) {
		ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
		for (int i = 0; i < 10; i++) {
			final int index = i;
			fixedThreadPool.execute(new Runnable() {
				public void run() {
					try {
						System.out.println(index);
						Thread.sleep(2000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			});
		}
	}
}
