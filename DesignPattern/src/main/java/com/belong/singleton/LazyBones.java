package com.belong.singleton;
/**
 * @Description: <p>懒汉模式-单例模式-线程不安全的
 * 非线程安全，只有用到了实例才会去实例化</p>
 * @Author : belong
 * @Date : 2017年8月19日
 */
public class LazyBones {
	private static LazyBones instance;

	private LazyBones() {}

	public static LazyBones getInstance() {
		if (instance == null) {
			instance = new LazyBones();
		}
		return instance;
	}
}
