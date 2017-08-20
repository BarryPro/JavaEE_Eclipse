package com.belong.singleton;

/**
 * @Description: <p>单例模式-枚举
 * 最简单的方式,要进行实例化的类放到枚举类的私有构造器中</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public enum Enum {
	INSTANCE;
	private Object object;
	// 要实例化的内容放到枚举类的私有构造器中
	private Enum() {
		object = new Object();
	}
	
	public Object getInstance() {
		return object;
	} 
}
