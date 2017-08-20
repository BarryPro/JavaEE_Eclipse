package com.belong.singleton;
/**
 * @Description: <p>采用内存屏障来解决多检锁的问题
 * 必须使用volatile来修饰实例化变量，防止指令重排
 * 为什么不让用，因为双重检索的线程安全完全依赖于volatile关键字，而volatile关键字在1.5前后用很大的差别
 * 1.5之前是不能用的，因为JVM对volatile关键字的实现有bug，不能解决“无序写入”所以双重检索就用不了了</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public class VolatileDCL {
	/**
	 * 采用volatile关键字来防止指令重排，同时根据java内存模型的happens-before规则
	 * volatile修饰的变量的写一定在读的前面完成，但是不能保证原子性
	 */
	private volatile static VolatileDCL singleton;

	private VolatileDCL (){}

	public static VolatileDCL getInstance() {
		/**
		 * 第一个if (instance == null)，其实是为了解决线程安全的懒汉模式中的效率问题，
		 * 只有instance为null的时候，才进入synchronized的代码段——大大减少了几率。 第二个if (instance ==
		 * null)，则是跟线程安全的懒汉模式一样，是为了防止可能出现多个实例的情况
		 ** 指令重排 ************************************************
		 * 1. 给 singleton 分配内存
		 * 2. 调用 Singleton 的构造函数来初始化成员变量，形成实例
         * 3. 将singleton对象指向分配的内存空间（执行完这步 singleton才是非 null 了）
		 */
		if (singleton == null) {
			synchronized (VolatileDCL.class) {
				if (singleton == null) {
					singleton = new VolatileDCL();
				}
			}
		}
		return singleton;
	}
}
