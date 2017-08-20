package com.belong.singleton;
/**
 * @Description: <p>登记式/静态内部类</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public class StaticInnerClass {
	// 静态内部类实现，采用jvm机制来进行控制单例，同时也是懒加载的模式，只有在调用实例化时才会进行创建
	private static class SingletonHolder {
		// 采用final使实例化后不能进行改变，双保险
		private static final StaticInnerClass INSTANCE = new StaticInnerClass();
	}

	private StaticInnerClass (){}

	public static final StaticInnerClass getInstance() {
		return SingletonHolder.INSTANCE;
	}
}
