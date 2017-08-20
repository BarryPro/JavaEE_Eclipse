package com.belong.singleton;
/**
 * @Description: <p>单例模式-饿汉模式
 * 避免了多线程，但是浪费资源，不管调不调用都会创建实例</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public class Eager {
	// 体现饿汉模式的思想，先进行实例化，也避免了多线程产生多个实例
	// 只要类被装载了就会进行实例化
	private static Eager instance = new Eager();

	private Eager() {}

	public static Eager getInstance() {
		return instance;
	} 
}
