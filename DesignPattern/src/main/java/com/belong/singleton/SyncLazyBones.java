package com.belong.singleton;
/**
 * @Description: <p>单例模式-懒汉模式-线程安全的
 * 但是效率低</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public class SyncLazyBones {
	private static SyncLazyBones instance;

	private SyncLazyBones() {}

	/**
	 * 整个实例方法都采用同步机制，锁粒度太大了，相当于多个线程都是串行的
	 * 效率低，不推荐使用
	 * @return 返回实例
	 */
	public static synchronized SyncLazyBones getInstance() {
		if (instance == null) {
			instance = new SyncLazyBones();
		}
		return instance;
	}
}
